local root_markers = { 'gradlew', 'mvnw', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)

local ok, local_cfg = pcall(require, 'config.local')
if not ok then
  local_cfg = {}
end

local user = local_cfg.user or os.getenv("USERNAME")
local appdata_local = "C:/Users/" .. user .. "/AppData/Local"

local eclipse_workspace_root = local_cfg.eclipse_workspace_root or (appdata_local .. "/Eclipse")
local jdtls_dir = local_cfg.jdtls_dir or (appdata_local .. "/EclipseJDT")

local jdtls_java = local_cfg.jdtls_java or "C:/Program Files/Java/jdk-21/bin/java"
local launch_java = local_cfg.launch_java or "C:/Program Files/Amazon Corretto/jdk21.0.3_9/bin/java"
local jdwp_arg = local_cfg.jdwp_arg

local function first_existing_path(paths, check_file)
  for _, path in ipairs(paths) do
    local target = check_file and (path .. "/" .. check_file) or path
    if vim.fn.empty(vim.fn.glob(target)) == 0 then
      return path
    end
  end
  return nil
end

local java_debug_dir = local_cfg.java_debug_dir or first_existing_path({
  appdata_local .. "/java-debug",
  appdata_local .. "/java-debug/java-debug",
}, "com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")

if not java_debug_dir then
  error(
    "java-debug jar not found. Checked:\n" ..
    appdata_local .. "/java-debug\n" ..
    appdata_local .. "/java-debug/java-debug"
  )
end

local launcher_jar = vim.fn.glob(jdtls_dir .. '/plugins/org.eclipse.equinox.launcher_*.jar')
if launcher_jar == "" then
  error("jdtls launcher jar not found in: " .. jdtls_dir .. "/plugins")
end

local debug_jar = vim.fn.glob(
  java_debug_dir .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
  1
)
if debug_jar == "" then
  error("java-debug plugin jar not found in: " .. java_debug_dir)
end

local workspace_folder = eclipse_workspace_root .. "/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local cmd = {
  jdtls_java,
}

if jdwp_arg and jdwp_arg ~= "" then
  table.insert(cmd, jdwp_arg)
end

vim.list_extend(cmd, {
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xmx1g',
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  '-jar', launcher_jar,
  '-configuration', jdtls_dir .. '/config_win',
  '-data', workspace_folder,
})

local config = {
  cmd = cmd,
  settings = {
    java = {}
  },
  capabilities = capabilities,
}

config.init_options = {
  bundles = {
    debug_jar
  }
}

require('jdtls').start_or_attach(config)
require('jdtls.dap').setup_dap({ 'hotcodereplace', 'auto' })
require('jdtls.dap').setup_dap_main_class_configs()

local dap = require('dap')
dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
  {
    javaExec = launch_java,
    modulePaths = {},
    name = "Launch YourClassName",
    request = "launch",
    type = "java"
  },
  {
    type = 'java',
    request = 'launch',
    name = 'Launch MindCraft',
    mainClass = 'net.minecraft.client.main.Main',
    projectName = 'MDK-main',
  }
}

vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = 'Error', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🟢', texthl = 'Warning', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '❌', texthl = 'Error', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = '📝', texthl = 'Info', linehl = '', numhl = '' })

local bufopts = {}
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<leader>ev', '<Cmd>lua require"jdtls".extract_variable()<CR>', bufopts)
vim.keymap.set('n', '<leader>ec', '<Cmd>lua require"jdtls".extract_constant()<CR>', bufopts)
vim.keymap.set('n', '<leader>em', '<Cmd>lua require"jdtls".extract_method()<CR>', bufopts)
vim.keymap.set('n', '<F2>', '<Cmd>lua require"jdtls".update_hotcode()<CR>', bufopts)
vim.keymap.set('n', '<F1>', '<Cmd>lua require"dap".continue()<CR>', bufopts)
vim.keymap.set('n', '<F10>', '<Cmd>lua require"dap".step_over()<CR>', bufopts)
vim.keymap.set('n', '<F11>', '<Cmd>lua require"dap".step_into()<CR>', bufopts)
vim.keymap.set('n', '<F12>', '<Cmd>lua require"dap".step_out()<CR>', bufopts)
vim.keymap.set('n', '<F9>', '<Cmd>lua require"dap".toggle_breakpoint()<CR>', bufopts)
vim.keymap.set('n', '<leader>db', '<Cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', bufopts)
vim.keymap.set('n', '<leader>dl', '<Cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', bufopts)
vim.keymap.set('n', '<leader>dr', '<Cmd>lua require"dap".repl.open()<CR>', bufopts)
vim.keymap.set('n', '<leader>dc', '<Cmd>lua require"dap".run_to_cursor()<CR>', bufopts)
vim.keymap.set('n', '<leader>de', '<Cmd>lua require"dapui".eval()<CR>', bufopts)
vim.keymap.set('v', '<leader>de', '<Cmd>lua require"dapui".eval()<CR>', bufopts)
vim.keymap.set('n', '<leader>du', '<Cmd>lua require"dapui".toggle()<CR>', bufopts)
-- scripts
vim.keymap.set("n", "<leader>jc", function()
  require("config.java_class_init").make_java_class_init()
end, { desc = "Make Java main class" })
