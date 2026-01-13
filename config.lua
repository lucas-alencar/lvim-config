-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Seta algumas configs permanentes no vim
vim.o.wrap = true
vim.o.linebreak = true

-- Add empty line at EOF
vim.opt.eol = true
vim.opt.fixendofline = true

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    if vim.fn.getline("$") ~= "" then
      vim.fn.append(vim.fn.line("$"), "")
    end
  end,
})

lvim.plugins = {
  -- Installs the MarkdownPreview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
  },
  -- Installs the quarto preview
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "jmbuhr/otter.nvim",
    },
    config = function()
      require("quarto").setup({
        lspFeatures = {
          enabled = true,
          languages = { "r", "python", "julia", "bash" },
        },
      })
    end,
  },
  -- Installs the nvim Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function ()
      require("nvim-surround").setup({
        -- Add b as boolean shortcut
        surrounds = {
          -- b vai envolver o texto com dois asteriscos
          ["n"] = {
            add = { "**", "**" },
            find = "%*%*(.-)%*%*",  -- regex para localizar o texto já envolto
            delete = "^%*%*(.-)%*%*$",
            change = "^%*%*(.-)%*%*$",
          },
        },
      })
    end,
  },
}

-- Adds Markdown Preview on lvim <leader> menu
lvim.builtin.which_key.mappings["m"] = {
  name = "Markdown",
  p = { "<cmd>MarkdownPreview<CR>", "Preview" },
  s = { "<cmd>MarkdownPreviewStop<CR>", "Stop preview" },
}

-- Closes vim preview on lvim exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    pcall(function()
      vim.cmd("MarkdownPreviewStop")
    end)
  end,
})

-- Autosave on TextChange or "esc" pressed
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged"}, {
  pattern = "*",
  command = "silent! wall",
})

