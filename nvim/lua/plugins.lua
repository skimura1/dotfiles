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
	use({
		"nvim-lualine/lualine.nvim",
		event = "BufEnter",
		config = function()
			require("configs.lualine")
		end,
		requires = { "nvim-web-devicons" },
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("configs.treesitter")
		end,
	})

	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lsp")
		end,
	})

	use("onsails/lspkind-nvim")
	use({
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		tag = "v<CurrentMajor>.*",
	})

	-- cmp: Autocomplete
	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("configs.cmp")
		end,
	})

	use("hrsh7th/cmp-nvim-lsp")

	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })

	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })

	-- LSP diagnostics, code actions, and more via Lua.
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("configs.null-ls")
		end,
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Mason: Portable package manager
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})

	use({
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("configs.mason-lsp")
		end,
		after = "mason.nvim",
	})

	-- Show colors
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" })
		end,
	})

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configs.gitsigns")
		end,
	})

	-- autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("configs.autopairs")
		end,
	})

  -- Harpoon
  use("theprimeagen/harpoon")
  
  -- Undotree
  use("mbbill/undotree")

  -- Fugitive
  use("tpope/vim-fugitive")

  use({
    'stevearc/oil.nvim',
    config = function()
      require("oil").setup()
    end,
  })
end)
