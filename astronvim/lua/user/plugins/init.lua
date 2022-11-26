-- Configure init plugins.
return {
	init = {
		-- You can disable default plugins as follows:
		-- ["goolord/alpha-nvim"] = { disable = true },

		-- You can also add new plugins here as well:
		-- Add plugins, the packer syntax without the "use"
		-- { "andweeb/presence.nvim" },
		-- {
		--   "ray-x/lsp_signature.nvim",
		--   event = "BufRead",
		--   config = function()
		--     require("lsp_signature").setup()
		--   end,
		-- },

		-- We also support a key value style plugin definition similar to NvChad:
		-- ["ray-x/lsp_signature.nvim"] = {
		--   event = "BufRead",
		--   config = function()
		--     require("lsp_signature").setup()
		--   end,
		-- },

		-- Install catppuccin plugin for corlorscheme.
		{
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				require("catppuccin").setup()
			end,
		},

		-- Install nightfox plugin for colorscheme.
		{
			"EdenEast/nightfox.nvim",
			as = "nightfox",
			config = function()
				require("nightfox").setup({
					options = {
						styles = { comments = "italic" },
					},
				})
			end,
		},

		-- Set rust-tools plugin, note: manages rust_analyzer lsp setup by itself.
		{
			"simrat39/rust-tools.nvim",
			after = "mason-lspconfig.nvim",
			config = function()
				require("rust-tools").setup({
					server = astronvim.lsp.server_settings("rust_analyzer"),
				})
			end,
		},

		-- Set typescript plugin, note: manages tsserver lsp setup by itself.
		{
			"jose-elias-alvarez/typescript.nvim",
			after = "mason-lspconfig.nvim",
			config = function()
				require("typescript").setup({
					server = astronvim.lsp.server_settings("tsserver"),
				})
			end,
		},
	},
}
