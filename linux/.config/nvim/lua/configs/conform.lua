local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    json = { "prettier" },
    ["yaml.ansible"] = { "ansible_lint" }, -- for Ansible playbooks
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },

  -- Custom formatter definitions
  formatters = {
    ansible_lint = {
      command = "ansible-lint",
      args = { "--write", "-" },
      stdin = true,
      condition = function(ctx)
        return vim.fn.executable("ansible-lint") == 1
          and vim.fn.filereadable(ctx.filename) == 1
      end,
    },
  },
}

return options

