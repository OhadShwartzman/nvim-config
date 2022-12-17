local cmp = require'cmp'
cmp.setup {
	snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
		['<C-n>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' }
	}, {
		{ name = 'buffer' }
	})
}

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
local language_servers = { 'clangd', 'texlab' }

for _, server in ipairs(language_servers) do
	require('lspconfig')[server].setup {
		on_attach = lsp_buf_setup,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		}
	}
end

-- Rust Configuration

-- Specific rust lsp remaps
local rust_lsp_setup = function(client, buffer)
	lsp_buf_setup(client, buffer)
	map_buff(buffer, 'n', '<leader>ca', '<cmd>RustCodeAction<CR>', map_options)
end

require('rust-tools').setup {
	server = {
		on_attach = rust_lsp_setup,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		}
	}
}
