-- Disable netrw for nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'tpope/vim-fugitive' }, -- Git

  { 'RRethy/nvim-treesitter-endwise' }, -- Autocomplete Ruby "end"

  { 'nvim-tree/nvim-tree.lua' }, -- File tree

  { 'myusuf3/numbers.vim' }, -- Toggle line number style depending on focus

  { 'AndrewRadev/splitjoin.vim' }, -- Convert between single/multi line statements

  { 'terryma/vim-multiple-cursors' }, -- Multiple cursors

  { 'tpope/vim-surround' }, -- Surround text

  { 'echasnovski/mini.pairs', version = '*' }, -- Autocomplete braces/quotes

  { 'mattn/emmet-vim' }, -- HTML expansion

  { 'numToStr/Comment.nvim', opts = {} }, -- Toggle comments for lines/visual regions

  { 'vim-test/vim-test' }, -- Test runner

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      -- 'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Show matching keybinds for in-progress commands
  { 'folke/which-key.nvim', opts = {} },

  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  -- { 'EdenEast/nightfox.nvim' },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          -- Only loaded if `make` is available
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
}, {})

-- [[ Options ]]

-- vim.cmd.colorscheme 'nightfox'

-- Fix Ruby indentation; prevent `.` from causing dedents
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/2566
vim.cmd [[autocmd FileType ruby setlocal indentkeys-=.]]

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Disable line wrap by default
vim.wo.wrap = false

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Don't save undo history across seessions
vim.o.undofile = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

-- [[ Keymaps ]]

-- Open new split panes to the right and bottom
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Map leader to ,
-- Load before plugins so that correct leader is used
vim.g.mapleader = ','
vim.g.maplocalleader = ','
-- TODO: leader key timeout 2000

-- :nw as a shortcut for disabling line wrap
vim.keymap.set('n', ':nw', '<ESC>:set nowrap<CR>')

-- Strip trailing whitespace on save, preserving cursor position
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = {"*"},
  callback = function(ev)
    save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Tabs
--   :t as an abbreviation for :tabnew
--   ctrl-l - next tab
--   ctrl-h - previous tab
--   :tb as a shortcut for :tab ball (Opens all buffers in tabs)
vim.cmd('cabbrev t tabnew')
vim.keymap.set('n', '<c-l>', ':tabn<CR>')
vim.keymap.set('n', '<c-h>', ':tabp<CR>')
vim.keymap.set('n', ':tb', ':tab ball<CR>')

-- Git
vim.keymap.set('n', ':Gblame', ':Git blame')

-- Folds
--   Leader-f to enable folds, Leader-nf to disable
--   Folds are disabled by default
vim.opt.foldlevel = 1
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.keymap.set('n', '<Leader>f', ':set foldenable<CR>')
vim.keymap.set('n', '<Leader>nf', ':set nofoldenable<CR>')
-- vim.keymap.set('n', ':fo', 'zA') -- When closed: open recursively. When open: close recursively, set foldenable
-- vim.keymap.set('n', ':cf', 'zc') -- Close one fold under the cursor, set foldenable

--  jk in insert mode as a shortcut for Escape
vim.keymap.set('i', 'jk', '<ESC>')

-- Typo fixes
vim.keymap.set('n', ':W', '<ESC>:w')
vim.keymap.set('n', ':X', '<ESC>:x')
vim.keymap.set('n', 'K', '<ESC>k')

-- :coloc/:nocoloc to toggle color column
vim.keymap.set('n', ':coloc', ':set colorcolumn=80<CR>')
vim.keymap.set('n', ':longcoloc', ':set colorcolumn=120<CR>')
vim.keymap.set('n', ':nocoloc', ':set colorcolumn=<CR>')

-- :mks to save session file
vim.keymap.set('n', ':mks', ':mksession! s.vim<CR>')

-- :pa/:nopa to toggle paste
vim.keymap.set('n', ':pa', ':set paste<CR>')
vim.keymap.set('n', ':nopa', ':set nopaste<CR>')

-- Tags
--   :cg to jump into tag, or show listing if multiple
--   :ct to open tag in new tab
--   :cv to open tag in vertical split
--   <C-t> to jump backwards in tag stack (alias :cb), <C-y> forwards
vim.cmd('map :ct :tab split<CR>:exec("tag ".expand("<cword>"))<CR>')
vim.cmd('map :cv :vsp <CR>:exec("tag ".expand("<cword>"))<CR>')
vim.cmd('map :cg g<C-]>')
vim.cmd('map <C-y> :tag<CR>')
vim.cmd('map :cb <C-t>')

-- Shift-tab to de-indent current line in insert mode
vim.keymap.set('i', '<S-Tab>', '<C-o><<')

-- Enable indentation with tab and shift-tab in visual mode
vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')

-- :d2s to convert double quotes to single quotes on current line
-- :s2d to convert single quotes to double quotes on current line
vim.keymap.set({'n', 'v'}, ':d2s', ':s/"/\'/g<CR>')
vim.keymap.set({'n', 'v'}, ':s2d', ':s/\'/"/g<CR>')

-- :sy and :su to yank into system clipboard
vim.keymap.set('v', ':sy', '"+y<CR>')
vim.keymap.set('v', ':su', '"+y<CR>')

-- [[ Configure colorscheme ]]
require('onedark').setup {
  style = 'warmer',
  code_style = {
    comments = 'none'
  },
  colors = {
    bg0 = '#000003', -- background
    codeschool_blue = '#5f87d7',
    codeschool_orange = '#dda790',
    codeschool_lightpurple = '#afafd7',
    codeschool_turquoise = '#5fafd7',
  },
  highlights = {
    ["@comment"] = {fg = '#969696'},
    ["@keyword"] = {fg = '#dda790'},             -- module, class, return
    ["@keyword.function"] = {fg = '$codeschool_orange'}, -- def
    ["@symbol"] = {fg = '$codeschool_blue'},     -- symbols
    ["@punctuation.delimiter"] = {fg = 'white'}, -- commas
    ["@punctuation.bracket"] = {fg = 'white'},   -- parens, brackets/braces
    ["@operator"] = {fg = 'white'},              -- &&, =, etc
    ["@parameter"] = {fg = 'white'},             -- method definition params (positional + kwarg)
    ["@variable"] = {fg = 'white'},              -- local variables, arguments
    ["@label"] = {fg = '$codeschool_turquoise'}, -- instance variables
    ["@type"] = {fg = '$codeschool_lightpurple'}, -- constants
    ["@conditional"] = {fg = '$codeschool_orange'}, -- if/else
    ["@function"] = {fg = '#a6ccf2'},            -- func names, call chains
    ["@number"] = {fg = '$codeschool_blue'},
    ["@float"] = {fg = '$codeschool_blue'},
    ["@boolean"] = {fg = '$codeschool_blue'},
    ["@constant"] = {fg = '$codeschool_lightpurple'},
    ["@string"] = {fg = '#87af5f'},
    ["@constant.builtin"] = {fg = '$codeschool_turquoise'}, -- nil
    ["@punctuation.special"] = {fg = 'white'},              -- string interp #{}
    ["@exception"] = {fg = '$codeschool_orange'},           -- raise (doesn't work?)
    ["@variable.builtin"] = {fg = '$codeschool_turquoise'}, -- super, self
    ["@repeat"] = {fg = '$codeschool_orange'},              -- break
    ["@none"] = {fg = 'white'}, -- :: inside string interpolation (??)
    ["@string.regex"] = {fg = '#bda061'},
    ["@string.escape"] = {fg = 'white'}, -- \n, etc
  }
}
require('onedark').load()

-- Disable LSP semantic highlights which snipe colorscheme on load
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end

-- Comment.nvim
--   :cc/:cu to toggle comments
require('Comment').setup({
  toggler = { line = ':cc' },
  opleader = { line = ':cc' }
})
vim.keymap.set({'n', 'v'}, ':cu', ':normal :cc<CR>')

require('lualine').setup({
  sections = {
    lualine_c = {
      -- Show relative filepaths in the status bar
      { 'filename', path = 1 }
    }
  }
})

-- NvimTree
--   :nt to open
--   :nf to open to current file
--   :nc to close
require("nvim-tree").setup({
  view = { width = 45 },
  git = { enable = false },
  renderer = {
    icons = {
      web_devicons = {
        file = { enable = false },
        folder = { enable = false }
      },
      glyphs = {
        folder = {
          arrow_closed = '▶',
          arrow_open = '▼'
        },
      },
      show = {
        git = false,
        file = false,
        folder = false,
      },
    }
  }
})
vim.keymap.set('n', ':nt', ':NvimTreeFocus<CR>')
vim.keymap.set('n', ':nf', ':NvimTreeFindFile<CR>')
vim.keymap.set('n', ':nc', ':NvimTreeToggle<CR>')


-- vim-test
--   Run tests with :terminal in a split-right window
--   Leader-s to run nearest spec, Leader-t to run whole file
vim.cmd('let test#strategy = "neovim"')
vim.cmd('let test#neovim#term_position = "vert"')
vim.cmd('let test#neovim#term_position = "vert botright"')
vim.keymap.set('n', '<Leader>s', ':TestNearest<CR>')
vim.keymap.set('n', '<Leader>t', ':TestFile<CR>')

require('mini.pairs').setup()

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    layout_config = {
      horizontal = {
        preview_cutoff = 999, -- Don't show preview panel
        width = 0.95,
      }
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- vim.keymap.set('n', '<leader>/', function()
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<c-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', ':ack', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    endwise = { enable = true },

    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'ruby', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- vaf to select outer function, cif to change inner function body, etc
          -- Can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      }
    },
  }
end, 0)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  Run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- Helper to define LSP mappings. Sets mode, buffer, and description
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

  -- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  -- nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  -- nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
  --   vim.lsp.buf.format()
  -- end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
-- require('which-key').register {
--   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--   ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
--   ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
--   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
-- }

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
}

-- Setup neovim lua configuration
-- require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
-- local cmp = require 'cmp'
-- local luasnip = require 'luasnip'
-- require('luasnip.loaders.from_vscode').lazy_load()
-- luasnip.config.setup {}
--
-- cmp.setup {
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   mapping = cmp.mapping.preset.insert {
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete {},
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ['<Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_locally_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--     ['<S-Tab>'] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.locally_jumpable(-1) then
--         luasnip.jump(-1)
--       else
--         fallback()
--       end
--     end, { 'i', 's' }),
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'luasnip' },
--   },
-- }

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
