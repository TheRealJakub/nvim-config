return {
  -- Mason: auto-install LSP servers
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "mason.nvim",
      "neovim/nvim-lspconfig", -- still needed for lsp/ config definitions
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ruff" },
        -- Automatically calls vim.lsp.enable() for installed servers
        automatic_enable = true,
      })
    end,
  },

  -- LSP keymaps via LspAttach autocmd
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Global LSP keymaps — fires when any LSP attaches to a buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(ev)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gr", vim.lsp.buf.references, "References")
          map("gi", vim.lsp.buf.implementation, "Implementation")
          map("K", vim.lsp.buf.hover, "Hover docs")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>D", vim.lsp.buf.type_definition, "Type definition")
          map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next diagnostic")
          map("<leader>dl", vim.diagnostic.open_float, "Line diagnostics")
        end,
      })

      -- Disable Ruff's hover in favour of Pyright's
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("DisableRuffHover", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        end,
      })
    end,
  },
}

