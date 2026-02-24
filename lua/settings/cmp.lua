local cmp = require("cmp")

return {
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},

	performance = {
		debounce = 60,
		throttle = 30,
		fetching_timeout = 500,
		filtering_context_budget = 3,
		confirm_resolve_timeout = 80,
		async_budget = 1,
		max_view_entries = 10,
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp", priority = 100 },
		{ name = "buffer", priority = 50, keyword_length = 3 },
		{ name = "path", priority = 40 },
	}),

	sorting = {
		priority_weight = 2,
		comparators = {
			require("cmp.config.compare").offset,
			require("cmp.config.compare").exact,
			require("cmp.config.compare").score,
			require("cmp.config.compare").recently_used,
			require("cmp.config.compare").locality,
			require("cmp.config.compare").kind,
			require("cmp.config.compare").sort_text,
			require("cmp.config.compare").length,
			require("cmp.config.compare").order,
		},
	},

	formatting = {
		expandable_indicator = true,
		fields = { "abbr", "kind", "menu" },
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			menu = {
				nvim_lsp = "[LSP]",
				buffer = "[Buffer]",
				path = "[Path]",
			},
		}),
	},

	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.confirm({ select = true }),
		["<C-y>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
	}),

	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
}
