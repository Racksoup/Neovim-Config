local M = {}

function M.make_react_component()
  local filename = vim.fn.expand("%:t:r")

  if filename == "" then
    vim.notify("Buffer has no filename", vim.log.levels.ERROR)
    return
  end

  local lines = {
    "import React from 'react';",
    "",
    "const " .. filename .. " = () => {",
    "  ",
    "  return (",
    "    <div className='" .. filename .. "'>",
    "",
    "    </div>",
    "  )",
    "}",
    "",
    "export default " .. filename .. ";",
  }

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  -- place cursor inside component body
  vim.api.nvim_win_set_cursor(0, {4, 2})
end

return M
