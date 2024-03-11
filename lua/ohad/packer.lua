require('packer').startup(function()
	use 'wbthomason/packer.nvim'

	use 'tpope/vim-surround'
	use 'gruvbox-community/gruvbox'

	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'mfussenegger/nvim-dap'

	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)
