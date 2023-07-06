local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

map("n", "<leader>pv", "<CMD>Ex<Cr>")

-- <leader> = the space key
map("n", " ", "<Nop>", { silent = true, remap = false })

-- Save
map("n", "<leader>w", "<CMD>update<CR>")

-- Quit
map("n", "<leader>q", "<CMD>q<CR>")

-- Exit insert mode
map("i", "jk", "<ESC>")
