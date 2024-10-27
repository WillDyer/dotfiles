-- PLUGINS --
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
     { "mrjones2014/nvim-ts-rainbow" },
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
                    ensure_installed = { "lua_ls", "pylsp" },
                    automatic_installation = false,
               })
          end
     },
     {
          "jay-babu/mason-null-ls.nvim",
          config = function()
               require("mason-null-ls").setup({
                    ensure_installed = { "flake8" },
                    automatic_installation = false,
               })
          end
     },
     { "neovim/nvim-lspconfig" },
}

-- LSP SETTINGS --
lvim.lsp.automatic_installation = false
lvim.lsp.installer.setup.automatic_installation = false

local null_ls = require("null-ls")

null_ls.setup({ ---@diagnostic disable-line: redundant-parameter
    sources = {
        null_ls.builtins.diagnostics.flake8,
    },
})

-- SETTINGS --
vim.opt.shell = "/bin/sh"
vim.cmd("set expandtab")
vim.cmd("set tabstop=5")
vim.cmd("set softtabstop=5")
vim.cmd("set shiftwidth=5")
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
lvim.builtin.treesitter.rainbow.enable = true

-- Colorscheme --
lvim.colorscheme = "tokyonight-moon"
lvim.transparent_window = false

-- LOCALS --
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<C-o>', ':Neotree toggle<CR>', {})
lvim.lsp.automatic_configuration.skipped_servers = { "pyright" }

-- KEYBINDS --
vim.keymap.set("n", "<C-c>", '"+y')
vim.keymap.set("v", "<C-c>", '"+y')
vim.keymap.set("n", "<C-v>", '"+p')
vim.keymap.set("i", "<C-v>", '<C-r>+')
vim.keymap.set('i', '<C-a>', '<Esc>ggVG<CR>a', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', '<C-a>', '<Esc>ggVG', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<C-o>:w<CR>', { noremap = true, silent = true })

lvim.keys.normal_mode["<C-u>"] = "<C-r>"
lvim.keys.normal_mode["<C-e>"] = "$"
lvim.keys.normal_mode["<C-b>"] = "0"
lvim.keys.normal_mode["<C-q>"] = ":q<CR>"
lvim.keys.normal_mode["<C-q>"] = "<C-o>:q<CR>"

-- Tree toggle --
vim.keymap.set("n", "<C-o>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- TreeSitter Configuration --
local configs = require("nvim-treesitter.configs")
configs.setup({
     ensure_installed = { "lua", "python" }, -- Install Lua and Python parsers
     highlight = { enable = true },         -- Enable highlighting
     indent = { enable = true },            -- Enable indentation
})

-- NVIMTREE --
vim.api.nvim_create_autocmd("BufEnter", {
     nested = true,
     callback = function()
          if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
               vim.cmd "quit"
          end
     end
})
