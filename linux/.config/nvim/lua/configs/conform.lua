-- ~/.config/nvim/lua/plugins/conform.lua
local ansible_lint_should_fix_all = true  -- or false

local ansible_lint_fixes = {
  -- [1] Fix uses of command module instead of shell
  "command-instead-of-shell",
  -- [2] Fix deprecated local_action usage
  "deprecated-local-action",
  -- [3] Fix deprecated modules
  "deprecated-module",
  -- [4] Convert to Fully Qualified Collection Names (FQCN)
  "fqcn",
  -- [5] Jinja syntax cleanup
  "jinja",
  -- [6] Normalize key order
  "key-order",
  -- [7] Ensure tasks have a name
  "name",
  -- [8] Use module arguments instead of free-form
  "no-free-form",
  -- [9] Avoid Jinja in when statements
  "no-jinja-when",
  -- [10] Hide password values from logs
  "no-log-password",
  -- [11] Add become: true consistently where needed
  "partial-become",
  -- [12] General YAML formatting
  "yaml",
}

local ansible_lint_fixed

if ansible_lint_should_fix_all then
  ansible_lint_fixed = { "all" }
else
  ansible_lint_fixed = ansible_lint_fixes
end

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    json = { "prettier" },
    yaml = { "ansible-lint" },
    ["yaml.ansible"] = { "ansible-lint" },
    ["ansible.yaml"] = { "ansible-lint" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  formatters = {
    ["ansible-lint"] = {
      command = "ansible-lint",
      args = function(ctx)
        local fix_list = table.concat(ansible_lint_fixed, ",")
        return { "--fix=" .. fix_list, "--nocolor", ctx.filename }
      end,
      stdin = false,
      condition = function(ctx)
        return vim.fn.executable("ansible-lint") == 1
            and vim.fn.filereadable(ctx.filename) == 1
      end,
    },
  },
}

require("conform").setup(options)
