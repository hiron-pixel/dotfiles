return {
	{
		"folke/tokyonight.nvim",

		"morhetz/gruvbox",

		"catppuccin/nvim",

		"rebelot/kanagawa.nvim",
},

	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority =1000,
		config = function()
			vim.cmd.colorscheme("cyberdream") 
		end, 
	}
}
	
