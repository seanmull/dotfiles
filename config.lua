--[[
lvim is the global options object
Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"
lvim.lsp.diagnostics.virtual_text = false
lvim.builtin.dap.active = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false
vim.opt.relativenumber = true

-- for being able to use gx to look at urls
vim.api.nvim_exec("nnoremap gx :!xdg-open <cWORD> &<CR><CR>", true)

vim.api.nvim_exec("nnoremap sh :!chmod +x % && source %<CR>", true)
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["L"] = { "<cmd>LazyGit<CR>", "LazyGit" }
lvim.builtin.which_key.mappings["B"] = { "<cmd>Telescope bookmarks<CR>", "Browser" }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Test",
	f = { "<cmd>TestFile -v<cr>", "TestFile" },
	n = { "<cmd>TestNearest -v<cr>", "TestNearest" },
}
-- lvim.builtin.which_key.mappings["d"] = {
-- name = "+Debug",
--   b = { "<cmd>call vimspector#ToggleBreakpoint()<cr>", "Toggle Breakpoint" },
--   c = { "<cmd>call vimspector#RunToCursor()<cr>", "Run to cursor" },
--   l = { "<cmd>call vimspector#Launch()<cr>", "Launch" },
--   i = { "<cmd>call vimspector#StepInto()<cr>", "Step Into" },
--   o = { "<cmd>call vimspector#StepOver()<cr>", "Step Over" },
--   r = { "<cmd>call vimspector#Reset()<cr>", "Reset" }
-- }

-- local result = vim.api.nvim_exec([[
--   let g:vimwiki_list =
--   [
--     {
--       'syntax': 'markdown',
--       'ext': '.md'
--     }
--   ]
-- ]]
--   , false)

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Runners available are 'pytest', 'nose', 'nose2', 'djangotest', 'djangonose', 'mamba', and Python's built-in unittest as 'pyunit'
vim.api.nvim_exec("let test#python#runner = 'pytest'", true)
-- TODO: Cannot get vimspector to see this directory
vim.api.nvim_exec("let g:vimspector_base_dir = expand('$HOME/dotfiles')", true)
vim.api.nvim_exec("let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]", true)
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"tsx",
	"css",
	"rust",
	"java",
	"yaml",
	"sql",
	"markdown",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumeko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc") end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	--   { command = "black", filetypes = { "python" } },
	--   { command = "isort", filetypes = { "python" } },
	{
		command = "stylua",
		filetypes = { "lua" },
	},
	{
		command = "shfmt",
		filetypes = { "bash" },
	},
	{
		-- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
		command = "prettier",
		---@usage arguments to pass to the formatter
		-- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
		extra_args = { "--print-with", "100", "--tab-width", "4" },
		---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
		filetypes = { "typescript", "typescriptreact", "javascript", "markdown", "json", "vimwiki" },
	},
})

-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	-- { command = "vale", filetypes = { "markdown" } },
	--   { command = "flake8", filetypes = { "python" } },
	-- { command = "eslint" },
	{
		-- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
		command = "shellcheck",
		---@usage arguments to pass to the formatter
		-- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
		-- extra_args = { "--severity", "warning" },
		-- filetypes = { "bash"  }
	},
	{
		command = "codespell",
		---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
		filetypes = { "javascript", "python", "typescript", "bash", "lua" },
	},
})

-- Additional Plugins
lvim.plugins = {
	{ "z0mbix/vim-shfmt" },
	-- { "vim-denops/denops.vim" },
	{ "tpope/vim-dadbod" },
	-- { "vim-denops/denops-helloworld.vim" },
	-- { "skanehira/k8s.vim" },
	{ "ckipp01/stylua-nvim", run = "cargo install stylua" },
	{
		"olivercederborg/poimandres.nvim",
		config = function()
			require("poimandres").setup({
				-- leave this setup function empty for default config
				-- or refer to the configuration section
				-- for configuration options
			})
		end,
	},
	{ "takac/vim-hardtime" },
	{ "tpope/vim-surround" },
	{ "folke/tokyonight.nvim" },
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{ "ggandor/lightspeed.nvim" },
	{ "metakirby5/codi.vim" },
	{ "vim-test/vim-test" },
	-- change defaults on bookmarks.lua to chrome and open_browser
	{ "dhruvmanila/telescope-bookmarks.nvim" },
	{ "tyru/open-browser.vim" },
	{ "kdheepak/lazygit.nvim" },
	{ "tpope/vim-fugitive" },
	-- { 'puremourning/vimspector' },
	{ "nvim-telescope/telescope-media-files.nvim" },
	{ "vimwiki/vimwiki" },
	{
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } },
	{ "nvim-telescope/telescope-dap.nvim" },
}

-- vim.api.nvim_exec("let g:hardtime_default_on = 1", true)

require("telescope").load_extension("bookmarks")
require("telescope").setup({
	extensions = {
		bookmarks = {
			selected_browser = "chrome",
			-- url_open_command = 'open',
			url_open_plugin = "open_browser",
			full_path = true,
			firefox_profile_name = nil,
		},
	},
})
require("telescope").load_extension("lazygit")
require("telescope").load_extension("media_files")
require("telescope").setup({
	extensions = {
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg", -- find command (defaults to `fd`)
		},
	},
})

require("telescope").load_extension("dap")
lvim.keys.normal_mode["<leader>F"] = ":Telescope dap frames<CR>"
lvim.keys.normal_mode["<leader>S"] = ":Telescope dap so<CR>"
lvim.keys.normal_mode["<leader>dU"] = "<cmd>lua require'dap'.up()<cr>"
lvim.keys.normal_mode["<leader>dD"] = "<cmd>lua require'dap'.down()<cr>"

local dap = require("dap")
dap.set_log_level("TRACE")
-- dap.adapters.javascript = {
--   type = 'server',
--   host = '127.0.0.1',
--   port = 3000
-- }
-- dap.adapters.node2 = {
--   type = 'executable',
--   command = '/usr/bin/node',
--   args = { os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js' },
-- }
dap.adapters.node = {
	type = "executable",
	command = "/usr/bin/node",
	args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}
dap.adapters.javascript = {
	type = "executable",
	command = "/usr/bin/node",
	args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}
dap.adapters.typescript = {
	type = "executable",
	command = "/usr/bin/node",
	args = { os.getenv("HOME") .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
}
require("dap.ext.vscode").load_launchjs(nil, { node = { "javascript", "typescript", "node2" } })

-- dap.configurations.javascript = {
--   {
--     -- name = 'Launch',
--     -- type = 'node2',
--     -- request = 'launch',
--     -- program = '${file}',
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     console = 'integratedTerminal',
--   },
--   {
--     -- For this to work you need to make sure the node process is started with the `--inspect` flag.
--     name = 'Attach to process',
--     type = 'node2',
--     request = 'attach',
--     port = 9229
--     -- processId = require 'dap.utils'.pick_process,
--   },
-- }
-- dap.configurations.typescript = {
--   {
--     name = 'Launch',
--     type = 'node2',
--     request = 'launch',
--     program = '${file}',
--     -- outFiles = "[${workspaceRoot}/dist/src/*.js]",
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = 'inspector',
--     console = 'integratedTerminal'
--   },
--   {
--     -- For this to work you need to make sure the node process is started with the `--inspect` flag.
--     name = 'Attach to process',
--     type = 'node2',
--     request = 'attach',
--     port = 9229
--     -- processId = require 'dap.utils'.pick_process,
--   },
-- }
-- require("dapui").setup()
lvim.keys.normal_mode["<leader>U"] = ":lua require('dapui').toggle()<CR>"
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "zsh",
	callback = function()
		-- let treesitter use bash highlight for zsh files as well
		require("nvim-treesitter.highlight").attach(0, "bash")
	end,
})