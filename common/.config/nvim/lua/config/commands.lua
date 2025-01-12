vim.api.nvim_create_user_command("Task", function(args)
  -- vim.cmd("belowright split | terminal task " .. args.args)
  vim.cmd("!task " .. args.args)
end, {
  nargs = "?",
  complete = function()
    -- タスクの自動補完（Taskfile.yml のタスク一覧を取得）
    local result = vim.fn.systemlist("task --list-all 2>/dev/null")
    if vim.v.shell_error ~= 0 then
      return {}
    end
    local tasks = {}
    for _, line in ipairs(result) do
      local task_name = line:match("%* ([^:]+):")
      if task_name then
        table.insert(tasks, task_name)
      end
    end
    return tasks
  end,
})
