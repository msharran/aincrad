require("neo-tree").setup({
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    }
})


vim.keymap.set('n', '<leader>ee', function()
    local reveal_file = vim.fn.expand('%:p')
    if (reveal_file == '') then
        reveal_file = vim.fn.getcwd()
    else
        local f = io.open(reveal_file, "r")
        if (f) then
            f.close(f)
        else
            reveal_file = vim.fn.getcwd()
        end
    end
    require('neo-tree.command').execute({
        action = "focus",          -- OPTIONAL, this is the default value
        source = "filesystem",     -- OPTIONAL, this is the default value
        position = "left",         -- OPTIONAL, this is the default value
        reveal_file = reveal_file, -- path to file or folder to reveal
        reveal_force_cwd = true,   -- change cwd without asking if needed
    })
end,
{ desc = "Open neo-tree at current file or working directory" }
);

vim.cmd [[
nnoremap <leader>ec :Neotree close<cr>
nnoremap <leader>eb :Neotree toggle show buffers reveal left<cr>
nnoremap <leader>eg :Neotree show git_status reveal left<cr>
]]


