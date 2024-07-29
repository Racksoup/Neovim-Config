local root_markers = {'gradlew', 'mvnw', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = "C:/Users/propa/AppData/Local/Eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local config = {
  cmd = {
    -- 💀
    "C:/Program Files/Amazon Corretto/jdk21.0.3_9/bin/java",
	  '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5006',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.glob('C:/Users/propa/AppData/Local/EclipseJDT/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', 'C:/Users/propa/AppData/Local/EclipseJDT/config_win',
    '-data', workspace_folder,
  },

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },
	capabilities = capabilities,
}

config['init_options'] = {
  bundles = {
    vim.fn.glob("C:/Users/propa/AppData/Local/java-debug/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
  };
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
require('jdtls.dap').setup_dap({'hotcodereplace', 'auto'})
require('jdtls.dap').setup_dap_main_class_configs()

local dap = require('dap')
dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 5005;
  },
	{
    javaExec = "C:/Program Files/Amazon Corretto/jdk21.0.3_9/bin/java",
    modulePaths = {},
    name = "Launch YourClassName",
    request = "launch",
    type = "java"
  },
	{
		-- doesn't work :) only know how to attach to mindcraft
		type = 'java';
		request = 'launch';
		name = 'Launch MindCraft';
		mainClass = 'net.minecraft.client.main.Main';
		projectName = 'MDK-main';
	}
}

-- styles
vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = 'Error', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🟢', texthl = 'Warning', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '❌', texthl = 'Error', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = 'Info', linehl = '', numhl = '' })


-- Keymaps
local bufopts = {desc = desc}
-- Go to definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
-- Find references
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
-- Go to implementation
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
-- Hover to show documentation
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
-- Code actions
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
-- Rename symbol
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
-- Extract variable
vim.keymap.set('n', '<leader>ev', '<Cmd>lua require"jdtls".extract_variable()<CR>', bufopts)
-- Extract constant
vim.keymap.set('n', '<leader>ec', '<Cmd>lua require"jdtls".extract_constant()<CR>', bufopts)
-- Extract method
vim.keymap.set('n', '<leader>em', '<Cmd>lua require"jdtls".extract_method()<CR>', bufopts)
-- Update Code
vim.keymap.set('n', '<F6>', '<Cmd>lua require"jdtls".update_hotcode()<CR>', bufopts)
-- Start debugging
vim.keymap.set('n', '<F5>', '<Cmd>lua require"dap".continue()<CR>', bufopts)
-- Step over
vim.keymap.set('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', bufopts)
-- Step into
vim.keymap.set('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', bufopts)
-- Step out
vim.keymap.set('n', '<F12>', '<Cmd>lua require"dap".step_out()<CR>', bufopts)
-- Toggle breakpoint
vim.keymap.set('n', '<F9>', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', bufopts)
-- Set conditional breakpoint
vim.keymap.set('n', '<leader>db', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', bufopts)
-- Log point
vim.keymap.set('n', '<leader>dl', '<Cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', bufopts)
-- Open REPL
vim.keymap.set('n', '<leader>dr', '<Cmd>lua require"dap".repl.open()<CR>', bufopts)
-- Run to cursor
vim.keymap.set('n', '<leader>dc', '<Cmd>lua require"dap".run_to_cursor()<CR>', bufopts)
-- Evaluate
vim.keymap.set('n', '<leader>de', '<Cmd>lua require"dapui".eval()<CR>', bufopts)
vim.keymap.set('v', '<leader>de', '<Cmd>lua require"dapui".eval()<CR>', bufopts)
-- DAP UI (optional)
vim.keymap.set('n', '<leader>du', '<Cmd>lua require"dapui".toggle()<CR>', bufopts)
