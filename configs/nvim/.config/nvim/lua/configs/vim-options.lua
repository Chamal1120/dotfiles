vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.termguicolors = true
vim.opt.relativenumber = true
vim.o.colorcolumn = "80"
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
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
vim.opt.undofile = true
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

-- Custom nvim commands
vim.api.nvim_create_user_command("Tms", function()
	vim.fn.jobstart({ "tmux", "new-window", "tmux-sessionizer" }, { detach = true })
end, {})

vim.api.nvim_create_user_command("Gropen", function()
	vim.fn.jobstart({ "gropen" }, { detach = true })
	vim.api.nvim_echo({ { "remote repo opened in default browser!", "Normal" } }, false, {})
end, {})

-- Navigate vim panes better
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

vim.keymap.set('n', '<C-M-l>', ':vertical resize +5<CR>',
  { noremap = true, silent = true, desc = 'Increase vertical split width' })
vim.keymap.set('n', '<C-M-h>', ':vertical resize -5<CR>',
  { noremap = true, silent = true, desc = 'Decrease vertical split width' })
vim.keymap.set('n', '<C-M-j>', ':resize +5<CR>',
  { noremap = true, silent = true, desc = 'Increase horizontal split height' })
vim.keymap.set('n', '<C-M-k>', ':resize -5<CR>',
  { noremap = true, silent = true, desc = 'Decrease horizontal split height' })

-- Other keymaps
vim.keymap.set("n", "<C-f>", ":Tms<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-g>", ":Gropen<CR>", { noremap = true, silent = true })

-- Custom filetype matchings
vim.filetype.add({
  extension = {
    bal = 'ballerina' -- Detect .bal as ballerina files
  },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang", -- Detect as hyprlang files
  },
})

vim.opt.winblend = 5
vim.cmd [[
  highlight BlinkCmpMenui guibg=#1e1e2e guifg=#cdd6f4
  highlight BlinkCmpMenuBorder guibg=#1e1e2e guifg=#89b4fa
  highlight BlinkCmpMenuSelection guibg=#3e4452 guifg=#cdd6f4
  highlight BlinkCmpScrollBarThumb guibg=#7f849c
  highlight BlinkCmpScrollBarGutter guibg=#1e1e2e
  highlight BlinkCmpLabel guibg=#1e1e2e guifg=#cdd6f4
  highlight BlinkCmpLabelDeprecated guibg=#1e1e2e guifg=#7f849c gui=strikethrough
  highlight BlinkCmpLabelDetail guibg=#1e1e2e guifg=#a6accd
  highlight BlinkCmpLabelDescription guibg=#1e1e2e guifg=#a6accd
  highlight BlinkCmpKind guibg=#1e1e2e guifg=#89b4fa
  highlight BlinkCmpSource guibg=#1e1e2e guifg=#89b4fa
  highlight BlinkCmpGhostText guibg=NONE guifg=#5c6370 gui=italic
  highlight BlinkCmpDoc guibg=#1e1e2e guifg=#cdd6f4
  highlight BlinkCmpDocBorder  guibg=#1e1e2e guifg=#89b4fa
  highlight BlinkCmpDocSeparator guibg=#1e1e2e guifg=#89b4fa
  highlight BlinkCmpDocCursorLine guibg=#3e4452
  highlight BlinkCmpSignatureHelp guibg=#1e1e2e guifg=#cdd6f4
  highlight BlinkCmpSignatureHelpBorder guibg=#1e1e2e guifg=#89b4fa
  highlight BlinkCmpSignatureHelpActiveParameter guibg=#89b4fa guifg=#1e1e2e
]]

-- Copilot colors
-- vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#363535" })
