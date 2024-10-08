local M = {}

local turbo_pascal = {
	background = "#101010", -- Black
	foreground = "#C0C0C0", -- Light gray
	comment = "#00B0B0", -- Light cyan
	keyword = "#FFFFFF", -- White for keywords
	string = "#FFFF00", -- Yellow
	number = "#FF00FF", -- Magenta
	type = "#00FF00", -- Bright green for types
	identifier = "#C0C0C0", -- Light gray for identifiers
	cursorline = "#222222", -- Darker gray for cursorline
	floatmenu = "#0b4f50",
	special = "#00FFFF",
	variables = "#999999",
	black = "#000000",
	white = "#FFFFFF",
	fn = "#41ddca",
}

local turbo_green = {
	-- background = '#272889', -- Blueish
	background = "#181a5f",
	foreground = "#FFFFFF", -- White
	comment = "#008680",
	keyword = "#FFFFFF", -- Orange
	string = "#FFA500",
	number = "#f461f4", -- Light gray
	type = "#00FF00", -- Green
	identifier = "#50FA7B", -- White
	cursorline = "#000050", -- Dark stuff
	floatmenu = "#0b595a",
	black = "#000000",
	white = "#FFFFFF",
	special = "#00FFFF",
	variables = "#faa378",
	floatmenu_pale = "#008080",
	fn = "#6afbc8",
}

local function treesitter_setup()
	require("nvim-treesitter.configs").setup({
		highlight = {
			enable = true,
			custom_captures = {
				["keyword"] = "Keyword",
				["string"] = "String",
				["number"] = "Number",
				["type"] = "Type",
				["identifier"] = "Identifier",
				["comment"] = "Comment",
				["function"] = "Function",
			},
		},
	})
end

M.modes = {
	base = turbo_green,
	pascal = turbo_pascal,
}

M.setup = function()
	-- Register the command with Neovim
	vim.api.nvim_create_user_command("TurboV", function(args)
		M.loadcolors({ ["mode"] = args["args"] })
	end, {
		nargs = 1,
		desc = "Set turbo vision themes",
		complete = function()
			return { "base", "pascal" }
		end,
	})
end

M.loadcolors = function(opts)
	local mode = opts["mode"] or "base"
	local colors = M.modes[mode] or M.modes.base

	vim.cmd("highlight clear")
	vim.cmd("syntax reset")

	vim.cmd("highlight Normal guifg=" .. colors.foreground .. " guibg=" .. colors.background)
	vim.cmd("highlight Comment guifg=" .. colors.comment)
	vim.cmd("highlight Keyword guifg=" .. colors.keyword)
	vim.cmd("highlight String guifg=" .. colors.string)
	vim.cmd("highlight Number guifg=" .. colors.number)
	vim.cmd("highlight Function guifg=" .. colors.fn)
	vim.cmd("highlight @variable guifg=" .. colors.variables)
	vim.cmd("highlight Type guifg=" .. colors.type)
	vim.cmd("highlight Special guifg=" .. colors.special)
	vim.cmd("highlight Identifier guifg=" .. colors.identifier)
	vim.cmd("highlight SignColumn guibg=" .. colors.background)
	vim.cmd("highlight CursorLine guibg=" .. colors.cursorline .. "guifg=fg")

	vim.api.nvim_set_hl(0, "Pmenu", { bg = colors.floatmenu, fg = colors.black })
	vim.api.nvim_set_hl(0, "PmenuSel", { bg = colors.white, fg = colors.floatmenu })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.floatmenu, fg = colors.black })
	vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#FF0000" })

	vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = colors.floatmenu, fg = colors.black })
	treesitter_setup()
end

return M

