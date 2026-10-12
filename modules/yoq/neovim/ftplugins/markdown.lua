vim.opt_local.conceallevel = 0
vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.wrap = true

local opts = { buffer = vim.api.nvim_get_current_buf() }

vim.keymap.set("v", "<C-b>", "s****<Esc>hPw", {
	unpack(opts),
	noremap = true,
	desc = "Make the text under the cursor bold",
})
vim.keymap.set("v", "<C-i>", "s__<Esc>Pw", {
	unpack(opts),
	noremap = true,
	desc = "Make the text under the cursor italic",
})
vim.keymap.set("v", "<C-c>", "s``<Esc>Pw", {
	unpack(opts),
	noremap = true,
	desc = "Make the text under the cursor italic",
})
