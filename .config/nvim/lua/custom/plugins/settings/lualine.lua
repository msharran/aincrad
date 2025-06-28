require('lualine').setup({
    options = {
        theme = "dracula-nvim",
        component_separators = " ",
    },
    sections = {
        lualine_c = {
            {
                'filename',
                file_status = true,    -- Displays file status (readonly status, modified status)
                newfile_status = true, -- Display new file status (new file means no write after created)
                path = 1,              -- 0: Just the filename
                -- 1: Relative path
                -- 2: Absolute path
                -- 3: Absolute path, with tilde as the home directory
                -- 4: Filename and parent dir, with tilde as the home directory
            }
        }
    }
})
