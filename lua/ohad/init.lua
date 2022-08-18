require'ohad.settings'

highlight_yank_group = vim.api.nvim_create_augroup('YankHighLight', {})

-- Highlight briefly on yank
vim.api.nvim_create_autocmd('TextYankPost', {
	group = highlight_yank_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({timeout=75, higroup='Visual'})
	end
})

local map_options = { noremap = true }

-- Set <space> as mapleader, used to use semicolon but the goto-next char search functionality is too important
-- to give up.
-- The nnoremap <space> <nop> is important since <space> is mapped to <right> by default.
vim.api.nvim_set_keymap('n', '<space>', '<nop>', map_options)
vim.g.mapleader = ' '

-- General Remaps

vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', map_options)
vim.api.nvim_set_keymap('n', 'Q', ':nohl<CR>', map_options)

-- Easy split-window navigation
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', map_options)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', map_options)
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', map_options)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', map_options)

require'ohad.packer'

