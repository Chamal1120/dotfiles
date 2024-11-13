-- Define a base directory for all sessions
local session_base_dir = vim.fn.stdpath("data") .. "/sessions"
vim.fn.mkdir(session_base_dir, "p") -- Create directory if it doesn't exist

-- Get the session file path based on the current working directory
local function get_session_file()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t") -- Get current folder name
	return session_base_dir .. "/" .. project_name .. ".vim"
end

-- Save the session for the current project
local function save_session()
	vim.cmd("mksession! " .. get_session_file())
end

-- Load the session for the current project
local function load_session()
	local session_file = get_session_file()
	if vim.fn.filereadable(session_file) == 1 then
		vim.cmd("source " .. session_file)
	end
end

-- Autocommand to automatically save the session on VimLeave
vim.api.nvim_create_autocmd("VimLeavePre", {
	pattern = "*",
	callback = save_session,
})

-- Autocommand to automatically load the session on VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = load_session,
})
