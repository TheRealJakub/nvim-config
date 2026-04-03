return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      -- Install parsers
      local parsers = {
        "vimdoc", "javascript", "typescript", "c", "lua", "rust",
        "jsdoc", "bash", "python", "markdown", "markdown_inline",
      }

      for _, parser in ipairs(parsers) do
        vim.schedule(function()
          ts.install(parser)
        end)
      end

      -- Build filetype list from parsers
      local patterns = {}
      for _, parser in ipairs(parsers) do
        local ok, fts = pcall(vim.treesitter.language.get_filetypes, parser)
        if ok then
          for _, ft in pairs(fts) do
            table.insert(patterns, ft)
          end
        end
      end

      -- Auto-start highlighting + indentation
      vim.api.nvim_create_autocmd("FileType", {
        pattern = patterns,
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    -- this plugin still uses master as its default branch
    dependencies = { { "nvim-treesitter/nvim-treesitter", branch = "main" } },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        multiwindow = false,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        on_attach = nil,
      })
    end,
  },
}

