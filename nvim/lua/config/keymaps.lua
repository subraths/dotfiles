local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<C-s>", "<esc><cmd>w<CR>", opts)
map("i", "<C-s>", "<esc><cmd>w<CR>", opts)

map("n", "<C-x>", "<cmd>bdelete!<CR>", opts)

map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", opts)
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", opts)

map("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "<esc><esc>", "<cmd>noh<CR>", opts)

map("n", "<C-j>", "<cmd>wincmd j<cr>", opts)
map("n", "<C-k>", "<cmd>wincmd k<cr>", opts)
map("n", "<C-h>", "<cmd>wincmd h<cr>", opts)
map("n", "<C-l>", "<cmd>wincmd l<cr>", opts)
