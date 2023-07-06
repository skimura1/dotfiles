-- Automatically run: PackerCompile
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  	-- Packer
	use("wbthomason/packer.nvim")
	-- Common utilities
	use("nvim-lua/plenary.nvim")
	-- Icons
	use("nvim-tree/nvim-web-devicons")
	-- Colorschema
	use("catppuccin/nvim")
	-- Statusline
	use("nvim-lualine/lualine.nvim")
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
	-- Telescope
	use("nvim-telescope/telescope.nvim")
	-- LSP
	use("neovim/nvim-lspconfig")
	use("onsails/lspkind-nvim")
  use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {                                      -- Optional
      'williamboman/mason.nvim',
      run = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    {'williamboman/mason-lspconfig.nvim'}, -- Optional
    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'hrsh7th/cmp-buffer'}, -- Required
    {'hrsh7th/cmp-path'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  }
}
	-- LSP diagnostics, code actions, and more via Lua.
	use("jose-elias-alvarez/null-ls.nvim")
	-- Mason: Portable package manager
	use("williamboman/mason.nvim")
	-- Show colors
	use("norcalli/nvim-colorizer.lua")
	-- Git
	use("lewis6991/gitsigns.nvim")
  -- Fugitive
  use("tpope/vim-fugitive")
	-- autopairs
	use("windwp/nvim-autopairs")
  -- Harpoon
  use("theprimeagen/harpoon")
  -- Undotree
  use("mbbill/undotree")
  -- File Explorer
  use('stevearc/oil.nvim')
  -- LSP UI
  use 'glepnir/lspsaga.nvim'
end)
