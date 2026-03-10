local M = {}

local out_dir = "out"
local main_class = "Main"

local function compile()
  vim.fn.mkdir(out_dir, "p")
  vim.cmd("!javac -d " .. out_dir .. " *.java")
end

local function run()
  compile()
  vim.cmd("!java -cp " .. out_dir .. " " .. main_class)
end

local function clean()
  vim.cmd("!rmdir /s /q " .. out_dir)
end

M.compile = compile
M.run = run
M.clean = clean

return M
