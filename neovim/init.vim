"--------------------------------"
" Plugin installation by vim-plug
"--------------------------------"

call plug#begin('~/.config/nvim/plugins')

" \/ Plugins \/
"Plug 'romgrk/barbar.nvim' " Tabline
Plug 'NLKNguyen/papercolor-theme' " Colorscheme
Plug 'kyazdani42/nvim-web-devicons' " Tabline requirement
Plug 'akinsho/nvim-bufferline.lua' " Buffer/Tabline
Plug 'nvim-lua/plenary.nvim' " Useful lua functions
Plug 'tpope/vim-fugitive' " Git integration
Plug 'vim-airline/vim-airline' " Status bar
Plug 'vim-airline/vim-airline-themes' " Status bar theme
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy search for files and buffers
Plug 'lukas-reineke/indent-blankline.nvim' " Help to see indentation
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'junegunn/vim-peekaboo'
" /\ Plugins /\
"
call plug#end()


"----------------------"
" PLUGIN CONFIGURATION "
"----------------------"

" nvim-bufferline
set termguicolors
lua require("bufferline").setup()

" vim-airline
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"----------------------"
"   LSP CONFIGURATION  "
"----------------------"

lua << EOF
require'lspconfig'.jedi_language_server.setup{}
EOF

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "jedi_language_server" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF



"----------------------"
" CODE COMPLETION CONFIGURATION "
"----------------------"

lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF



"----------------------"
" GENERAL CONFIGURATION "
"----------------------"

" Configure python bindings
let g:python3_host_prog='/usr/bin/python3'
let g:python_host_prog='/usr/bin/python2'


colorscheme PaperColor


set encoding=utf-8

" Change line number column to white
highlight LineNr ctermfg=white

" Default behavior

" Highlight all matches of the last search
set hlsearch

" Highlight matching pattern while typing the search command
set incsearch

" keep 100 lines of command line history
set history=100

" show the cursor position all the time. It also show more informations like
" line & column of the cursor
set ruler

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.d,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,__pycache__

" turn hybrid line numbers on
set number relativenumber

" Enable mouse in all modes
set mouse=a

" automatic load syntax highlight
syntax on

" Open vertical splits to the right
set splitright

" map up and down keys to move up and down by visible lines not the actual real
" lines (aka. separated by linebreak) (only works in command mode)
map <Up> gk
map <Down> gj

" Any buffer can be hidden (keeping its changes) without first writing
" the buffer to a file
set hidden

" Make tab to complete commands works like in bash
set wildmenu
set wildmode=longest,list

" Run shell commands in split windows
command! -nargs=* Shell set splitright | vnew | r! <args>

" Always have at least 5 lines below cursor (useful for search)
set scrolloff=5

" Move between buffers using f3 and f4
nmap <F3> :bprev<CR>
nmap <F4> :bnext<CR>

" Move between the last two buffers
nmap <F5> :b#<CR>

" Pretty print json
command! PrettyJson :%!python -m json.tool

" Highlight current line
set cursorline
