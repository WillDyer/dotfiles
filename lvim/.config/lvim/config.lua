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
     { "petertriho/nvim-scrollbar" },
     { "lewis6991/gitsigns.nvim" },
     { "kevinhwang91/nvim-hlslens" },

}

-- LSP SETTINGS --
lvim.lsp.automatic_installation = false
lvim.lsp.installer.setup.automatic_installation = false

vim.g.python3_host_prog = "/usr/autodesk/maya2024/bin/mayapy"

--local lspconfig = require("lspconfig")
--lspconfig.pyright.setup{
--     settings = {
--          pyhton = {
--               pythonPath = "/usr/bin/python3.12:/usr/autodesk/maya2024/bin/mayapy",
--               analysis = {
--                    extraPaths = { "/usr/autodesk/maya2024/lib/python3.10/site-packages" },
--                    autoImportComplettions = true,
--                    typeCheckingMode = "off",
--                    diagnosticMode = "workspace",
--                    useLibaryCodeForTypes = true,
--               },
--          },
--     },
--}

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
local null_ls = require("null-ls")

null_ls.setup({ ---@diagnostic disable-line: redundant-parameter
    sources = {
        null_ls.builtins.diagnostics.flake8,
    },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
     { command = "flake8", filetypes = { "python" }}
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
lvim.transparent_window = true

-- LOCALS --
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })
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
lvim.keys.insert_mode["<C-z>"] = "<Esc>ua"

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

-- SCROLLBAR --
require("gitsigns").setup()
require("hlslens").setup()
require("scrollbar").setup {
     show = true,
     handle = {
          color = "#5c6370",
          hide_if_all_visible = false,
     },
     marks = {
          Search = { color = "#d19a66" },
          Error = { color = "#e06c75" },
          Warn = { color = "#e5c07b" },
          Info = { color = "#56b6c2" },
          Hint = { color = "#98c379" },
          GitAdd = { color = "#98c379" },
          GitChange = { color = "#e5c07b" },
          GitDelete = { color = "#e06c75" },
     },
     excluded_buftypes = {"terminal"},
     excluded_filetypes = {"NvimTree"},
     handlers = {
          gitsigns = true,   -- Enables integration with gitsigns
          search = true,     -- Enables integration with nvim-hlslens
          diagnostic = true -- disable if you get lsp errors
     }
}

