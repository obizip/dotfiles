local M = {}

M.find_project_files = function ()
  local cwd = vim.fn.getcwd()
  local buf_dir = vim.fn.expand("%:p:h")
  vim.cmd("cd " .. buf_dir)
  local git_root = vim.fn.system("git rev-parse --show-toplevel | tr -d '\\n'")
  vim.cmd("cd " .. cwd)
  if string.match(git_root, "%s") ~= nil then
    require"telescope.builtin".find_files({ cwd = buf_dir})
  else
    require"telescope.builtin".find_files({ cwd = git_root})
  end
end

return M
