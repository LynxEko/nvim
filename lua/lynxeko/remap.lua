vim.g.mapleader = " "

-- exit to file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move lines on select mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- appends the next line to this one without moving the cursor (by default moves the cursor to the end of the current line)
vim.keymap.set("n", "J", "mzJ`z")

-- makes the page up/down with the cursor on the center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- when searching keep the cursor in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- replace pasting without losing content
vim.keymap.set("x", "<leader>p", '"_dP')

-- yanking to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Q is anoying idk what it does but shows an error
vim.keymap.set("n", "Q", "<nop>")

-- replace word in entire buffer
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- reload nvim config
vim.keymap.set("n", "<leader><CR>", "<cmd>lua ReloadConfig()<CR>")
