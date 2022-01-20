_ = vim.cmd [[packadd packer.nvim]]

return require('packer').startup {
  function(use)
    use 'wbthomason/packer.nvim'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    use "neovim/nvim-lspconfig"
    use 'williamboman/nvim-lsp-installer'
    use "wbthomason/lsp-status.nvim"
    use {
      "ericpubu/lsp_codelens_extensions.nvim",
      config = function()
        require("codelens_extensions").setup()
      end,
    }

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
    }

    -- Sources
    use "hrsh7th/nvim-cmp"
    -- use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lsp-document-symbol"
    use "saadparwaiz1/cmp_luasnip"
    use "tamago324/cmp-zsh"

    use "L3MON4D3/LuaSnip"
    use "onsails/lspkind-nvim"

    use "github/copilot.vim"

    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"
    use "mfussenegger/nvim-dap-python"
    use "nvim-telescope/telescope-dap.nvim"

    -- Comparators
    use "lukas-reineke/cmp-under-comparator"

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

    use "numToStr/FTerm.nvim"

    use {
      'akinsho/bufferline.nvim',
      requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use "tpope/vim-dadbod"
    use { "kristijanhusak/vim-dadbod-completion" }
    use { "kristijanhusak/vim-dadbod-ui" }

    --colorschemes
    use 'matsuuu/pinkmare'
    use 'ful1e5/onedark.nvim'
    use 'folke/tokyonight.nvim'
    use 'rockerBOO/boo-colorscheme-nvim'
    use 'torcor-dev/purple_winter'
    use 'shaunsingh/nord.nvim'
    use {
        "mcchrish/zenbones.nvim",
        requires = "rktjmp/lush.nvim"
    }

    use { "tpope/vim-dispatch", cmd = { "Dispatch", "Make" } }

    use {
      "rhysd/git-messenger.vim",
      keys = "<Plug>(git-messenger)",
    }

    use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use "rhysd/committia.vim"
    use "sindrets/diffview.nvim"

    use "rktjmp/shipwright.nvim"

    use "bfredl/nvim-luadev"
    use "chrisbra/Colorizer"

  end
}
