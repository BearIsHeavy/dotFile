vim.opt.termguicolors = true

require("bufferline").setup {
    options = {
        -- use lsp in build-in vim
        diagnostics = "nvim_lsp",

        -- nvim-lsp in left-side
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
        }}
    }
}
