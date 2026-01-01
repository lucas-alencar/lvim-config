-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- Seta algumas configs permanentes no vim
vim.o.wrap = true
vim.o.linebreak = true

-- Instala o Markdown Preview
lvim.plugins = {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
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

