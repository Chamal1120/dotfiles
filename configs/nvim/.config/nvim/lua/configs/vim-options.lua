vim.g.mapleader = " " -- set leader to space
-- vim.g.maplocalleader = " " -- set local leader to space
vim.o.termguicolors = true
vim.opt.relativenumber = true
vim.o.colorcolumn = "80" -- highlight column 80
vim.g.have_nerd_font = true
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.mouse = "a"
vim.opt.showmode = false -- don't show mode
vim.opt.showcmd = false
vim.opt.guicursor = "n-v-i-c:block-Cursor"

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
-- vim.schedule(function()
--   vim.opt.clipboard = "unnamedplus"
-- end)

vim.opt.breakindent = true
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
vim.opt.cursorline = false
-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
-- vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- vim.cmd("set expandtab")
-- vim.cmd("set tabstop=2")
-- vim.cmd("set softtabstop=2")
-- vim.cmd("set shiftwidth=2")

-- Navigate vim panes better
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- Custom filetype matchings
vim.filetype.add({
	extension = {
		bal = 'ballerina' -- Detect as ballerina files
	},
	pattern = {
		[".*/hypr/.*%.conf"] = "hyprlang", -- Detect as hyprlang files
	},
})

-- Copilot colors
-- vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#363535" })
