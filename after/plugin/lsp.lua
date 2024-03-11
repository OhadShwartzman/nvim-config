local cmp = require'cmp'
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

vim.opt.completeopt="menu,menuone,noselect"

local map_buff = vim.api.nvim_buf_set_keymap
local map_options = { noremap = true }

-- These are the general mappings for LSP functions I chose to keep.
-- Chose to have a default set of mappings for ~most~ language servers, and some specific language servers
-- can use other on_attach functions
local lsp_buf_setup = function(_, buffer)
	map_buff(buffer, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', map_options)
	map_buff(buffer, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', map_options)
	map_buff(buffer, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', map_options)
	map_buff(buffer, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', map_options)
	map_buff(buffer, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', map_options)
	map_buff(buffer, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', map_options)
	map_buff(buffer, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_options)
	map_buff(buffer, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', map_options)
	map_buff(buffer, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_options)
	map_buff(buffer, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], map_options)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Language servers to use with the general remaps - no specific per-language customization
local language_servers = { 'clangd', 'texlab', 'rust_analyzer' }

for _, server in ipairs(language_servers) do
	require('lspconfig')[server].setup {
		on_attach = lsp_buf_setup,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		}
	}
end
