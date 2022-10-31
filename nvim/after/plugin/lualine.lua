-- local search_results = function()
-- 		if vim.v.hlsearch == 1 then
-- 				local searchcount =vim.fn.searchcount()
-- 				return '[' .. searchcount["current"] .. "/" .. searchcount["total"] .. "] "
-- 		else
-- 				return ""
-- 		end
-- end
-- Because cmdheight=0 makes the default counter go away - https://www.reddit.com/r/neovim/comments/vb8l3y/comment/ic9kg99/

require('lualine').setup{
	options = {
		theme = 'auto',
		icons_enabled = false,
		section_separators = '',
		component_separators = '',
	},
	sections = {
		lualine_c = { {'filename', path = 1} }, -- 0 = just filename, 1 = relative path, 2 = absolute path
		lualine_x = {},
		lualine_y = {'encoding', 'fileformat', 'filetype'},
	}
}
