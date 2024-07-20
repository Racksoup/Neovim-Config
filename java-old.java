local home = "C:/Users/propa"
local jdtls = require('jdtls')
local dap = require('dap')


-- File types that signify a Java project's root directory.
local root_markers = {'gradlew', 'mvnw', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)

-- Workspace directory for project-specific data
local workspace_folder = home .. "/AppData/Local/Eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Helper function for creating keymaps
local function nnoremap(rhs, lhs, bufopts, desc)
  bufopts.desc = desc
  vim.keymap.set("n", rhs, lhs, bufopts)
end

-- The on_attach function to set key maps after the language server attaches
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
  nnoremap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
  nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
  nnoremap('T', vim.lsp.buf.hover, bufopts, "Hover text")
  nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
  nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
  nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
  nnoremap('<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts, "List workspace folders")
  nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
  nnoremap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
  nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
  vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
    { noremap=true, silent=true, buffer=bufnr, desc = "Code actions" })
  nnoremap('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")

  -- Java extensions provided by jdtls
  nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
  nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
  nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
  vim.keymap.set('v', "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
    { noremap=true, silent=true, buffer=bufnr, desc = "Extract method" })

end

local bundles = {
  vim.fn.glob("C:/Users/propa/AppData/Local/java-debug/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-0.53.0.jar", 1),
};

-- vim.list_extend(bundles, vim.split(vim.fn.glob("C:/Users/propa/AppData/Local/vscode-java-test/vscode-java-test/server/*.jar", 1), "\n"))

local config = {
  flags = {
    debounce_text_changes = 80,
  },
  on_attach = on_attach,
  root_dir = root_dir,
	init_options = {
		bundles = {
			vim.fn.glob("C:/Users/propa/AppData/Local/java-debug/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
  	}
	},
	--init_options = { bundles = bundles },
  settings = {
    java = {
      format = {
        settings = {
          url = home .. "/AppData/Local/Eclipse/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*", "sun.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = "C:/Program Files/Amazon Corretto/jdk21.0.3_9",
          },
          {
            name = "JavaSE-17",
            path = "C:/Program Files/Amazon Corretto/jdk17.0.12_7",
          },
          {
            name = "JavaSE-11",
            path = "C:/Program Files/Amazon Corretto/jdk11.0.24_8",
          },
          {
            name = "JavaSE-1.8",
            path = "C:/Program Files/Amazon Corretto/jdk1.8.0_422"
          },
        }
      }
    }
  },
  cmd = {
    "C:/Program Files/Amazon Corretto/jdk21.0.3_9/bin/java",
		'-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.glob('C:/Users/propa/AppData/Local/EclipseJDT/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', 'C:/Users/propa/AppData/Local/EclipseJDT/config_win',
    '-data', workspace_folder,
  },
}

config['on_attach'] = function(client, bufnr)
  -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end

-- Start or attach to the JDTLS language server
jdtls.start_or_attach(config)

dap.set_log_level('DEBUG')

-- Define M and its execute_command function
local M = {}

M.execute_command = function(params, callback)
    vim.lsp.buf_request(0, 'workspace/executeCommand', params, function(err, _, result, _, _)
        callback(err, result)
    end)
end

dap.adapters.java = function(callback, config)
	M.execute_command({command = 'vscode.java.startDebugSession'}, function(err0, port)
		assert(not err0, vim.inspect(err0))
		callback({ type = 'server'; host = '127.0.0.1'; port = port; })
	end)
end

dap.configurations.java = {
    {
        type = 'java',
        request = 'attach',
        name = "Attach to Minecraft",
        hostName = '127.0.0.1',
        port = 5005,
    },
		{
        type = 'java',
        request = 'launch',
        name = "Launch Java Application",
        mainClass = "com.example.Main",  -- or specify a main class
        projectName = workspace_folder,
    },
		{
			javaExec = "C:/Program Files/Amazon Corretto/jdk21.0.3_9/bin/java",
			mainClass = "com.example.Main",
			modulePaths = {},
			name = "Launch YourClassName",
			request = "launch",
			type = "java"
		},
}

-- require('dap.ext.vscode').load_launchjs()

local function nnoremap(rhs, lhs, desc)
  local bufopts = {desc = desc}
  vim.keymap.set("n", rhs, lhs, bufopts)
end

-- nvim-dap
nnoremap("<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Set breakpoint")
nnoremap("<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Set conditional breakpoint")
nnoremap("<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "Set log point")
nnoremap('<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear breakpoints")
nnoremap('<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', "List breakpoints")

nnoremap("<leader>dc", "<cmd>lua require'dap'.continue()<cr>", "Continue")
nnoremap("<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", "Step over")
nnoremap("<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", "Step into")
nnoremap("<leader>do", "<cmd>lua require'dap'.step_out()<cr>", "Step out")
nnoremap('<leader>dd', "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect")
nnoremap('<leader>dt', "<cmd>lua require'dap'.terminate()<cr>", "Terminate")
nnoremap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", "Open REPL")
nnoremap("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", "Run last")
nnoremap('<leader>di', function() require"dap.ui.widgets".hover() end, "Variables")
nnoremap('<leader>d?', function() local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes) end, "Scopes")
nnoremap('<leader>df', '<cmd>Telescope dap frames<cr>', "List frames")
nnoremap('<leader>dh', '<cmd>Telescope dap commands<cr>', "List commands")

