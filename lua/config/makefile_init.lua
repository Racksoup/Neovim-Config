local M = {}

function M.make_makefile()
  local lines = {
    "OUT = out",
    "SRC = $(wildcard *.java)",
    "MAIN = Main",
    "",
    "run: compile",
    "\tjava -cp $(OUT) $(MAIN)",
    "",
    "compile:",
    "\t-mkdir $(OUT)",
    "\tjavac -d $(OUT) $(SRC)",
    "",
    "clean:",
    "\t-rmdir /s /q $(OUT)",
  }

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  -- place cursor on MAIN so you can edit quickly
  vim.api.nvim_win_set_cursor(0, { 3, 7 })
end

return M
