local km = vim.keymap 

km.set("i", "<S-Tab", "<C-d>", { noremap = true, silent = true })
km.set("v", "<S-Tab", "<", { noremap = true, silent = true })
km.set("n", "<S-Tab", "<<", { noremap = true, silent = true })

km.set("i", "jj", "<Esc>", { noremap = true, silent = true})

km.set("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { silent = true})
