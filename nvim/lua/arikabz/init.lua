require("arikabz.set")
require("arikabz.remap")
require("arikabz.send-to-repl")

require('arikabz.send-to-repl').setup({
  clear_on_send_buffer = true,  -- Clear REPL when sending entire buffer
  method = "direct",  -- Use "clipboard" if direct method doesn't work
  auto_send_on_save = false,  -- Optionally auto-send buffer on save
})



local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
