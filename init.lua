local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug 'tpope/vim-surround'
Plug 'gruvbox-community/gruvbox'
Plug 'jlanzarotta/bufexplorer'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'mfussenegger/nvim-dap'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'simrat39/rust-tools.nvim'

Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})

vim.call('plug#end')

vim.cmd 'colorscheme gruvbox'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.env.nowrap = true
vim.env.nobackup = true
vim.env.nowb = true
vim.env.noswapfile = true

vim.opt.smarttab = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.signcolumn = 'number'

vim.cmd 'augroup FUAD'
	vim.cmd 'autocmd InsertEnter * :set norelativenumber'
	vim.cmd 'autocmd InsertLeave * :set relativenumber'
vim.cmd 'augroup END'

local map = vim.api.nvim_set_keymap
local map_buff = vim.api.nvim_buf_set_keymap
local map_options = { noremap = true }
vim.g.mapleader = ';'

-- PLUGINS
-- -- -- -- 

-- Plug Explorer
vim.g.bufExplorerDefaultHelp=0
vim.g.bufExplorerShowRelativePath=1
vim.g.bufExplorerFindActive=1
vim.g.bufExplorerSortBy='name'
map('n', '<leader>o', ':BufExplorer<cr>', map_options)

-- vim-cmp
local cmp = require('cmp')
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
		['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item.
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' }
	}, {
		{ name = 'buffer' }
	})
}

vim.opt.completeopt="menu,menuone,noselect"

local on_attach = function(_, buffer)
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

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local language_servers = { 'rust_analyzer' }

for _, server in ipairs(language_servers) do
	require('lspconfig')[server].setup {
		on_attach = on_attach,
		capabilities = capabilities
	}
end

-- Rust Tools

require('rust-tools').setup({})

-- Telescope

map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', map_options)
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', map_options)

-- Treesitter Highlighting

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}

-- Remaps

map('n', '<leader>w', ':w<CR>', map_options)
map('n', 'Q', ':nohl<CR>', map_options)
map('n', '<space>', ';', map_options) -- Preserve semicolon behaviour but in space

map('n', '<C-j>', '<C-W>j', map_options)
map('n', '<C-k>', '<C-W>k', map_options)
map('n', '<C-h>', '<C-W>h', map_options)
map('n', '<C-l>', '<C-W>l', map_options)
