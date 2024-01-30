local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false end
local packer_bootstrap = ensure_packer() return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- use 'akinsho/nvim-toggleterm.lua'
  use 'onsails/lspkind.nvim'
  use 'mfussenegger/nvim-jdtls'
  -- symbol tree with tree-sitter
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })
  use 'simrat39/symbols-outline.nvim'
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use({
      "robitx/gp.nvim",
  })
  use 'norcalli/nvim-colorizer.lua'
  use 'szw/vim-maximizer'
  -- use {
  --     "windwp/nvim-autopairs",
  --     config = function() require("nvim-autopairs").setup {} end
  -- }
  -- Your plugins converted from vim-plug to packer
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }
  -- use 'rcarriga/nvim-notify'
  -- use 'mfussenegger/nvim-jdtls'
  -- tmux navigation
  use 'christoomey/vim-tmux-navigator'
  -- Auto complete while typing
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  -- dep for autocomplete cmp
  use "rafamadriz/friendly-snippets"
  use({
      "roobert/tailwindcss-colorizer-cmp.nvim",
      -- optionally, override the default options:
      config = function()
          require("tailwindcss-colorizer-cmp").setup({
              color_square_width = 2,
          })
      end
  })

  use { "themaxmarchuk/tailwindcss-colors.nvim",
  -- load only on require("tailwindcss-colors")
  module = "tailwindcss-colors",
  -- run the setup function after plugin is loaded
  config = function ()
      -- pass config options here (or nothing to use defaults)
      require("tailwindcss-colors").setup()
  end
}

  use 'Rigellute/shades-of-purple.vim'
  use 'pantharshit00/vim-prisma'
  use 'vim-airline/vim-airline'
  -- rainbow brackets
  use 'HiPhish/rainbow-delimiters.nvim'
  -- better UI for telescope questions and variable renaming stuff
  use 'stevearc/dressing.nvim'

  -- syntax theme
  use 'tanvirtin/monokai.nvim'

  use 'nvim-tree/nvim-tree.lua'
  use {
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-context',
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
  }

  use {
      "AckslD/nvim-neoclip.lua",
      requires = {
          {'kkharji/sqlite.lua', module = 'sqlite'},
          -- you'll need at least one of these
          -- {'nvim-telescope/telescope.nvim'},
          -- {'ibhagwan/fzf-lua'},
      },
      config = function()
          require('neoclip').setup({
          enable_persistent_history = true,
          continuous_sync = true,
      })
      end,
  }

  -- this one is kind of stupid
  use {
      'nvimdev/dashboard-nvim',
      event = 'VimEnter',
      config = function()
          require('dashboard').setup {
              theme = 'hyper',
              config = {
                  week_header = {
                      enable = true,
                  },
                  shortcut = {
                      { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                      {
                          icon = ' ',
                          icon_hl = '@variable',
                          desc = 'Files',
                          group = 'Label',
                          action = 'Telescope find_files',
                          key = 'f',
                      },
                      {
                          desc = ' Apps',
                          group = 'DiagnosticHint',
                          action = 'Telescope app',
                          key = 'a',
                      },
                      {
                          desc = ' dotfiles',
                          group = 'Number',
                          action = 'Telescope dotfiles',
                          key = 'd',
                      },
                  },
              },
          }
      end,
      requires = {'nvim-tree/nvim-web-devicons'}
  }

  -- dont really know how these work but they are all for git
  use 'jreybert/vimagit'
  use 'tpope/vim-fugitive'
  use 'rbong/vim-flog'
  use 'lewis6991/gitsigns.nvim'

  -- ys, ds, and cs for altering text objects, parenthesis and quotes
  use 'tpope/vim-surround'

  -- use 'preservim/nerdtree'
  use 'ryanoasis/vim-devicons'
  -- use 'tiagofumo/vim-nerdtree-syntax-highlight'

  -- use 'terryma/vim-multiple-cursors'
  use 'prettier/vim-prettier'
  -- gcc commands for commenting!!!
  use 'tpope/vim-commentary'

  -- bar at the top of the screen
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
  use 'github/copilot.vim'

  -- random language specific stuff
  use 'mattn/emmet-vim'
  use 'othree/html5.vim'
  use 'thosakwe/vim-flutter'
  use 'dart-lang/dart-vim-plugin'
  use {'evanleck/vim-svelte', branch = 'main'}
  use 'preservim/vim-markdown'


  -- use {'ms-jpq/coq_nvim', branch = 'coq'}
  -- use {'ms-jpq/coq.artifacts', branch = 'artifacts'}

  -- use {'ms-jpq/coq.thirdparty', branch= '3p'}

  -- all telescope stuff
  use "debugloop/telescope-undo.nvim"
  use 'BurntSushi/ripgrep'
  use 'sharkdp/fd'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.5',
      -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
      require("toggleterm").setup()
  end}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
