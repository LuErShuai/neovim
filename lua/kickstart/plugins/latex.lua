return {
    'lervag/vimtex',
    opt = true,
    config = function ()
        vim.g.vimtex_compiler_silent = 0
        vim.g.vimtex_quickfix_mode = 0
        vim.g.vimtex_view_method = 'general'
        vim.g.vimtex_compiler_progname = 'nvr'
        vim.g.vimtex_view_general_viewer = 'okular'
        vim.g.vimtex_compiler_latexmk_engines = {
            _ = '-xelatex'
        }
        vim.g.tex_comment_nospell = 1
        vim.g.vimtex_view_general_options = [[--unique file:@pdf#src:@line@tex]]
        vim.g.vimtex_view_general_options_latexmk = '--unique'
    end,
    ft = 'tex',
    lazy = false,
}
