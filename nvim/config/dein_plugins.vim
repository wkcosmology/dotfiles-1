let $CACHE_PATH = expand("$HOME") . '/.config/nvim'

function! s:dein_init()

    " dein global options
    " let g:dein#auto_recache = 1
    let g:dein#install_max_processes = 12
    " let g:dein#install_progress_type = 'title'
    " let g:dein#enable_notification = 1

    let s:dein_repo = $CACHE_PATH . '/dein/repos/github.com/Shougo/dein.vim'
    let s:dein_data = $CACHE_PATH . '/dein'

    if &compatible
      set nocompatible
    endif

    " dein auto load
    if &runtimepath !~# '/dein.vim'
        " Clone dein if first-time setup
        if !isdirectory(s:dein_repo)
            execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo
            if v:shell_error
                call s:error('dein installation has failed! is git installed?')
                finish
            endif
        endif
        execute 'set runtimepath+='.substitute(
            \ fnamemodify(s:dein_repo, ':p') , '/$', '', '')
    endif


    "========================
    " Plugins
    "========================
    if dein#load_state(s:dein_data)
        call dein#begin(s:dein_data)

        call dein#add(s:dein_repo)
        " completion
        call dein#add('neovim/nvim-lspconfig', {
            \'on_event': 'BufRead',
            \'hook_source': "lua require('custom.lspconfig')",
            \})

        call dein#add('glepnir/lspsaga.nvim', {
              \"on_event": "BufRead",
              \"on_cmd": "Lspsaga",
              \"depends": "nvim-lspconfig",
              \})
        " call dein#add('hrsh7th/nvim-compe' ,{
        "       \'on_event': 'InsertEnter',
        "       \'hook_source': "
        "         \lua << EOF\n
        "         \require'compe'.setup {
        "         \  enabled = true;
        "         \  autocomplete = true;
        "         \  debug = false;
        "         \  min_length = 1;
        "         \  preselect = 'always';
        "         \  allow_prefix_unmatch = false;
        "         \  source = {
        "         \    path = true;
        "         \    buffer = true;
        "         \    vsnip = true;
        "         \    nvim_lsp = true;
        "         \    nvim_lua = true;
        "         \  };
        "         \}\n 
        "         \EOF\n",
        "       \})
        call dein#add('hrsh7th/nvim-compe')
        " call dein#add('steelsojka/completion-buffers', {
        "       \'on_source': 'completion-nvim',
        "       \'hook_source': "let g:completion_word_ignored_ft = ['LuaTree','vista']",
        "       \})
        " call dein#add('nvim-lua/completion-nvim', {
        "       \'on_event': ["BufReadPre","BufNewFile"],
        "       \'hook_source': "autocmd BufReadPre,BufNewFile * lua require'completion'.on_attach()",
        "       \})
        
        " dress up
        call dein#add('ryanoasis/vim-devicons')
        call dein#add('glepnir/dashboard-nvim')
        " call dein#add('66RING/eleline.vim')
        call dein#add('glepnir/galaxyline.nvim', {'hook_post_source':"lua require('statusline.moonline')"})
        call dein#add('66RING/bookmarks-nvim')
        " call dein#add('glepnir/spaceline.vim')
        call dein#add('mg979/vim-xtabline')

        " colortheme
        " call dein#add('glepnir/zephyr-nvim', {'hook_post_source':"lua require('zephyr') "})
        " call dein#add('nvim-treesitter/nvim-treesitter')


        " enhance
        call dein#add('norcalli/nvim-colorizer.lua', {
            \ 'hook_source': "    
                \lua << EOF\n
                \ require 'colorizer'.setup {
                \   css = { rgb_fn = true; };
                \   scss = { rgb_fn = true; };
                \   sass = { rgb_fn = true; };
                \   stylus = { rgb_fn = true; };
                \   vim = { names = false; };
                \   tmux = { names = false; };
                \   'javascript';
                \   'javascriptreact';
                \   'typescript';
                \   'typescriptreact';
                \   html = {
                \     mode = 'foreground';
                \   }
                \ } \n
                \EOF\n"
              \ })
        call dein#add('itchyny/vim-cursorword', {'on_event':['BufReadPre,BufNewFile']})
        " Genreal Highlighter
        " call dein#add('jaxbot/semantic-highlight.vim', {
        "             \'on_ft': ['python', 'java', 'javascript', 'typescript', 'c', 'cpp'], 
        "             \'hook_source': 'autocmd BufEnter,BufNew,BufWritePre,FileWritePre *.py,*.ts,*.js,*.cpp,*.c,*.java :SemanticHighlight'
        "             \})
        

        " markdown
        call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					\ 'build': 'sh -c "cd app && yarn install"' })
        call dein#add('dhruvasagar/vim-table-mode', { 'on_ft': 'markdown' })
        call dein#add('dkarter/bullets.vim', { 'on_ft': 'markdown' })
           
        " snips
        " Track the engine.
        " call dein#add('honza/vim-snippets')
        " call dein#add('SirVer/ultisnips', {
        "       \'hook_source': "
        "         \let g:UltiSnipsExpandTrigger=\"<C-e>\"\n
        "         \let g:UltiSnipsJumpForwardTrigger=\"<c-l>\"\n
        "         \let g:UltiSnipsJumpBackwardTrigger=\"<c-j>\"\n
        "         \let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/config/Ultisnips']
        "         \",
        "       \})
        call dein#add('hrsh7th/vim-vsnip', {
              \'on_event': 'InsertCharPre',
              \'hook_source': 'let g:vsnip_snippet_dir = getenv("HOME") . "/.config/nvim/config/vsnips"',
              \})
        call dein#add('hrsh7th/vim-vsnip-integ', {
              \'on_event': 'InsertCharPre'
              \})

        call dein#add('tpope/vim-commentary')
        
        
        " git
        call dein#add('airblade/vim-gitgutter')
        
        
        " something useful
        call dein#add('junegunn/vim-easy-align' , { 'on_map': {'xn': '<Plug>(EasyAlign)'}})
        call dein#add('tpope/vim-surround') " type ysiw' i sur in word '' or type cs'` to change 'word' to `word` or 'ds' del sur or 'yss'' for sur line h h-> 'h h'
        call dein#add('easymotion/vim-easymotion', { 'on_map': {'n': '<Plug>'}})
        " fuzzy find
        call dein#add('liuchengxu/vim-clap', { 
                    \'hook_post_update': ':Clap install-binary' ,
                    \'on_cmd': 'Clap',
                    \})
        " call dein#add('nvim-lua/popup.nvim', { 'on_source': 'telescope.nvim'})
        " call dein#add('nvim-lua/plenary.nvim', { 'on_source': 'telescope.nvim'})
        " call dein#add('nvim-telescope/telescope.nvim', { 'on_cmd': 'Telescope'})


        call dein#add('mg979/vim-visual-multi')

        call dein#add('Shougo/defx.nvim', {
                    \'on_cmd': 'Defx', 
                    \'hook_post_source':"
                          \call defx#custom#option('_', {
                          \    'floating_preview': 1,
                          \    'winwidth': 30,
                          \    'split': 'vertical',
                          \    'direction': 'topleft',
                          \    'columns': 'mark:indent:git:icons:filename:type:size:time',
                          \    'show_ignored_files': 0,
                          \    'root_marker': '[in]: ',
                          \})
                          \\n
                          \call defx#custom#column('git', {
                          \   'indicators': {
                          \     'Modified'  : '•',
                          \     'Staged'    : '✚',
                          \     'Untracked' : 'ᵁ',
                          \     'Renamed'   : '≫',
                          \     'Unmerged'  : '≠',
                          \     'Ignored'   : 'ⁱ',
                          \     'Deleted'   : '✖',
                          \     'Unknown'   : '⁇'
                          \   }
                          \ })
                          \\n
                          \call defx#custom#column('mark', { 
                          \     'readonly_icon': '',
                          \     'selected_icon': '' 
                          \})"
                    \})
        call dein#add('kristijanhusak/defx-icons', {'on_source':'defx.nvim'})

        call dein#add('voldikss/vim-translator', { 'on_map': {'xn': '<Plug>TranslateW'}})
        
        " taglist
        call dein#add('liuchengxu/vista.vim', { 'on_cmd': ['Vista', 'Vista!', 'Vista!!']})
        " call dein#add('junegunn/vim-peekaboo')

        " indentLine
        call dein#add('Yggdroot/indentLine', { 
              \ 'on_event': 'BufReadPre', 
              \ 'hook_source': "
              \ let g:indentLine_enabled = 1 \n
              \ let g:indentLine_char='¦' \n
              \ let g:indentLine_fileTypeExclude = ['defx', 'json', 'denite','startify','dbui','vista_kind','vista','coc-explorer','dashboard','chadtree', 'markdown'] \n
              \ let g:indentLine_concealcursor = 'inc' \n
              \ let g:indentLine_showFirstIndentLevel =1 \n
              \ "})
        
        " call dein#add('glepnir/indent-guides.nvim')
        " call dein#add('glepnir/indent-guides.nvim', { 
        "     \'hook_post_source': "
        "       \lua << EOF\n
        "       \   require('indent_guides').options = { 
        "       \     indent_levels = 30;
        "       \     indent_guide_size = 1;
        "       \     indent_start_level = 1;
        "       \     indent_space_guides = true;
        "       \     indent_tab_guides = false;
        "       \     indent_soft_pattern = '\\\\s';
        "       \     indent_pretty_guides = false;
        "       \     exclude_filetypes = {'dashboard'}
        "       \   } \n
        "       \EOF\n"
        "     \})

        " search selected
        call dein#add('bronson/vim-visual-star-search')
        
        
        " database
        call dein#add('tpope/vim-dadbod')
        call dein#add('kristijanhusak/vim-dadbod-ui', 
                    \{
                    \ 'on_cmd': ['DBUIToggle', 'DBUIAddConnection', 'DBUI', 'DBUIFindBuffer', 'DBUIRenameBuffer'] ,
                    \ 'on_source': 'vim-dadbod'
                    \})
        
        
        " coding
        " golang
        " call dein#add('fatih/vim-go', { 'on_ft': 'go', 'hook_post_update': ':GoUpdateBinaries' })
        
        
        " CSharp
        " call dein#add('OmniSharp/omnisharp-vim', { 'on_ft': 'cs' })
        " call dein#add('ctrlpvim/ctrlp.vim' , { 'on_ft': ['cs', 'vim-plug']}) " omnisharp-vim dependency
        
        " HTML, CSS, JavaScript, PHP, JSON, etc.
        " call dein#add('elzr/vim-json', { 'on_ft': 'json' })
        " call dein#add('hail2u/vim-css3-syntax', { 'on_ft': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] })
        " call dein#add('spf13/PIV', { 'on_ft' :['php', 'vim-plug'] })
        " call dein#add('pangloss/vim-javascript', { 'on_ft': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] })
        " call dein#add('yuezk/vim-js', { 'on_ft': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] })
        " call dein#add('MaxMEllon/vim-jsx-pretty', { 'on_ft': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] })
        " call dein#add('jelera/vim-javascript-syntax', { 'on_ft': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] })
        "Plug 'jaxbot/browserlink.vim'
        " call dein#add('alvan/vim-closetag', { 'on_ft': ['html', 'js', 'jsx', 'vue']})

        call dein#add('mattn/emmet-vim', { 
              \ 'on_event': 'InsertEnter', 
              \ 'on_ft': [ 'html','css','javascript','javascriptreact','vue','typescript','typescriptreact' ], 
              \ 'hook_source': "
                \let g:user_emmet_mode = 'ivn'\n
                \let g:user_emmet_leader_key=','\n
                \"
              \})   
        " div>li>a  div+li+a*3  div>li>a^p  div>(li>a)^p
        " V: div>li*  * means for each line
        " div[hello="1"]{TEXT} or some css selector grammar
        " ul>li#item$*5  different number at least one digit
        " ul>li#item$@3*5  start counting from 3, -3 as  reverse
        " emmet ket + d, D, n, N, m, k, j, /, a

        call dein#add('AndrewRadev/tagalong.vim')
        
        " Python
        " call dein#add('Vimjas/vim-python-pep8-indent', { 'on_ft' :['python', 'vim-plug'] })
        " call dein#add('numirias/semshi', { 'hook_post_update': ':UpdateRemotePlugins', 'on_ft' :'python', 'hook_post_source': ':SemshiHighlight'})
        " Plug 'tweekmonster/braceless.vim'
        
        " Processing
        call dein#add('sophacles/vim-processing', { 'on_ft': ['processing'] })

        call dein#end()
        call dein#save_state()
    endif

    if has('vim_starting') && !empty(argv()) && execute('filetype') =~# 'OFF'
        " Lazy loading
        silent! filetype plugin indent on
        syntax enable
        filetype detect
    endif

    " if !has('vim_starting')
        call dein#call_hook('source')
        call dein#call_hook('post_source')
    " endif

endfunction


if has('vim_starting')
  call s:dein_init()
endif
