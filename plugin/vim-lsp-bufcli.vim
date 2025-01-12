vim9script
#
# * https://buf.build/docs/reference/cli/buf/beta/lsp/
# * https://github.com/bufbuild/buf-language-server?tab=readme-ov-file
# * https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#buf_ls

g:lsp_show_message_log_level = 'log'
g:lsp_log_file = expand("~/vim-lsp.log")

var server_info = {
    name: 'buf',
    cmd: (server_info) => [
        'buf',
        'beta',
        'lsp',
        '--debug',
        '--timeout=0',
        '--log-format=text',
    ],
    allowlist: ['proto'],
    config: {},
    root_uri: (server_info) => {
        return lsp#utils#path_to_uri(
            lsp#utils#find_nearest_parent_file_directory(
                lsp#utils#get_buffer_path(), ['buf.yaml', '.git']))
    },
    workspace_config: {},
    initialization_options: {},
}

if executable('buf')
    augroup lsp_bufcli
        autocmd!
        autocmd User lsp_setup call lsp#register_server(server_info)
    augroup END
endif

defcompile
