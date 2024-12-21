-- PLUGINS --
-- w
lvim.plugins = {
     { 'nvim-telescope/telescope-ui-select.nvim' },
     { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
     { "folke/tokyonight.nvim" },
     {
          "nvim-tree/nvim-tree.lua",
          dependencies = {
               "nvim-tree/nvim-web-devicons", -- optional, for file icons
          }
     },
     {
          "jiaoshijie/undotree",
          dependencies = "nvim-lua/plenary.nvim",
          config = true,
          keys = { { "<C-t>", "<cmd>lua require('undotree).toggle()<cr>" } },
     },
     {
          "williamboman/mason.nvim",
          config = function()
               require("mason").setup()
          end
     },
     {
          "williamboman/mason-lspconfig.nvim",
          config = function()
               require("mason-lspconfig").setup({
                    ensure_installed = { "lua_ls" },
                    automatic_installation = false,
               })
          end
     },
     {
          "jay-babu/mason-null-ls.nvim",
          config = function()
               require("mason-null-ls").setup({
                    ensure_installed = { "" },
                    automatic_installation = false,
               })
          end
     },
     { "mrjones2014/nvim-ts-rainbow" },
     { "neovim/nvim-lspconfig" },
     {
          "andweeb/presence.nvim",
          config = function()
          require("presence"):setup({
            auto_update         = true,
            neovim_image_text   = "LunarVim",
            main_image          = "file",
            log_level           = nil,
            debounce_timeout    = 10,
            enable_line_number  = false,
            blacklist           = {},
            buttons             = true,
            file_assets         = {},
          })
          end
     },
}

-- LSP SETTINGS --
lvim.lsp.automatic_installation = false
lvim.lsp.installer.setup.automatic_installation = false
vim.g.python3_host_prog = "/usr/autodesk/maya2024/bin/mayapy"

--vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
local null_ls = require("null-ls")

null_ls.setup({ ---@diagnostic disable-line: redundant-parameter
     sources = {
        null_ls.builtins.diagnostics.ruff.with({
               extra_args = { "--config", "~/.config/ruff/ruff.toml" },
          }),
     },
})


-- SETTINGS --
vim.opt.shell = "/bin/sh"
vim.cmd("set expandtab")
vim.cmd("set tabstop=5")
vim.cmd("set softtabstop=5")
vim.cmd("set shiftwidth=5")
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
lvim.builtin.treesitter.rainbow.enable = true

-- Colorscheme --
lvim.colorscheme = "tokyonight-moon"
lvim.transparent_window = true

-- LOCALS --
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })
lvim.lsp.automatic_configuration.skipped_servers = { "pyright" }

-- KEYBINDS --
vim.keymap.set('v', '<C-y>', '"+y', { noremap = true, silent = true }) -- Copy to system clipboard
vim.keymap.set('v', '<C-x>', '"+d', { noremap = true, silent = true }) -- Cut to system clipboard
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true, silent = true }) -- Paste from system clipboard

vim.api.nvim_set_keymap('v', '<C-a>', '<Esc>ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<C-o>:w<CR>', { noremap = true, silent = true })

-- lvim.keys.normal_mode["<C-u>"] = "<C-r>"
lvim.keys.normal_mode["<C-e>"] = "$"
-- lvim.keys.normal_mode["<C-b>"] = "0"
lvim.keys.normal_mode["<C-q>"] = ":q<CR>" -- save and quit
lvim.keys.normal_mode["<C-q>"] = "<C-o>:q<CR>" -- save and quit
lvim.keys.insert_mode["<C-z>"] = "<Esc>ua"
-- lvim.keys.normal_mode["<C-t>"] = ":split | term"

-- split lvim windows
lvim.keys.normal_mode["<C-h>"] = ":split<CR>"
lvim.keys.normal_mode["<C-j>"] = ":vsplit<CR>"

-- select all
lvim.keys.normal_mode["<C-a>"] = "ggVG"
lvim.keys.visual_mode["<C-a>"] = "<Esc>ggVG"
lvim.keys.insert_mode["<C-a>"] = "<Esc>ggVG"


-- Tree toggle --
vim.keymap.set("n", "<C-o>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- TreeSitter Configuration --
local configs = require("nvim-treesitter.configs")
configs.setup({
     ensure_installed = { "lua", "python" }, -- Install Lua and Python parsers
     highlight = { enable = true },         -- Enable highlighting
     indent = { enable = true },            -- Enable indentation
     fold = { enable = true },
})
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = true
vim.o.foldlevel = 99

-- NVIMTREE --
vim.api.nvim_create_autocmd("BufEnter", {
     nested = true,
     callback = function()
          if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
               vim.cmd "quit"
          end
     end
})

