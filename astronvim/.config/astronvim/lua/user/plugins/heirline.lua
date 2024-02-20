-- Heirline setup for winbar, breadcrumbs and statusline.
local heirline = function(config)
	-- First element of default configuration table is the statusline.
	config[1] = {
		hl = { fg = "fg", bg = "bg" },
		astronvim.status.component.mode({ mode_text = { padding = { left = 1, right = 1 } } }),
		astronvim.status.component.file_info(),
		astronvim.status.component.git_branch(),
		astronvim.status.component.git_diff(),
		astronvim.status.component.fill(),
		astronvim.status.component.lsp({ lsp_client_names = false }),
		astronvim.status.component.diagnostics(),
		astronvim.status.component.lsp({ lsp_progress = false }),
		astronvim.status.component.nav({ scrollbar = false }),
	}
	return config
end

return heirline
