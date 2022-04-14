local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug 'tpope/vim-surround'
Plug 'gruvbox-community/gruvbox'

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

require("ohad/settings")

vim.cmd 'augroup OHAD'
	vim.cmd 'autocmd InsertEnter * :set norelativenumber'
	vim.cmd 'autocmd InsertLeave * :set relativenumber'
vim.cmd 'augroup END'

vim.cmd [[
	augroup YankHighlight
		autocmd!
		autocmd TextYankPost * silent! lua vim.highlight.on_yank({timeout=75, higroup='Visual'})
	augroup end
]]

local map = vim.api.nvim_set_keymap
local map_buff = vim.api.nvim_buf_set_keymap
local map_options = { noremap = true }

-- Set <space> as mapleader, used to use semicolon but the goto-next char search functionality is too important
-- to give up.
-- The nnoremap <space> <nop> is important since <space> is mapped to <right> by default.
map('n', '<space>', '<nop>', map_options)
vim.g.mapleader = ' '

-- PLUGINS
-- -- -- -- 

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

-- Import lsp configurations - LSP-esque mappings can be found there
require('ohad/lsp')

-- Telescope

map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', map_options)
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>', map_options)
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>', map_options)

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

-- General Remaps

map('n', '<leader>w', ':w<CR>', map_options)
map('n', 'Q', ':nohl<CR>', map_options)

-- Easy split-window navigation
map('n', '<C-j>', '<C-W>j', map_options)
map('n', '<C-k>', '<C-W>k', map_options)
map('n', '<C-h>', '<C-W>h', map_options)
map('n', '<C-l>', '<C-W>l', map_options)
