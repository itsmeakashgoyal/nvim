--Enable the new |lua-loader| that byte-compiles and caches lua files.
vim.loader.enable()

-- setup editor options -> syntax -> autocmds -> mappings
require("config")

-- bootstrap lazy.nvim
require("config.lazy")

require "settings"
require "autocommands"
require "mappings"
require "telescope-setup"
require "lsp"

-- Load custom modules
require "custom-completions"
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath "config" .. "/lua/user_functions", [[v:val =~ '\.lua$']])) do
    require("user_functions." .. file:gsub("%.lua$", ""))
end

-- Searches for a .nvimrc file from the current directory up to the root and executes it if found.
vim.api.nvim_create_autocmd(
    "BufEnter",
    {
        pattern = "*",
        callback = function()
            local project_config_path = vim.fn.findfile(".nvimrc", ".;")
            if project_config_path ~= "" then
                loadfile(project_config_path)()
            end
        end
    }
)
