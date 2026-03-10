local M = {}

function M.make_java_class_init()
  -- Get filename without extension
  local filename = vim.fn.expand("%:t:r")

  if filename == "" then
    vim.notify("Buffer has no filename", vim.log.levels.ERROR)
    return
  end

  local lines = {
    "public class " .. filename .. " {",
    "    public static void main(String[] args) {",
    "        ",
    "    }",
    "}",
  }

  -- Replace whole buffer with class template
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  -- Put cursor inside main body
  vim.api.nvim_win_set_cursor(0, { 3, 8 })
end

return M
