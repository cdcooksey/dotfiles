vim.api.nvim_create_user_command("RuffFix", function()
  vim.cmd("write")

  vim.fn.system({
    "ruff",
    "check",
    "--fix",
    vim.fn.expand("%:p"),
  })

  vim.cmd("edit")
end, {})
