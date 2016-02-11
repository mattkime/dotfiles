" vimrc
" John Cockrell <hello@sjhcockrell.com>


" Set up pathogen for modules.
" @see https://github.com/tpope/vim-pathogen
filetype off
call pathogen#infect()
call pathogen#helptags()
" filetype plugin indent on


" don't bother with vi compat
set nocompatible

" enable syntax highlighting
syntax enable


" BASIC CONFIGURATION
"  Placed down here because I was noticing some strange overwrites/behavior
"	after introducing `vim-airline` on my tab and trailing space highlighting.
"
"	See Square's Maximum Awesome, as well.
"	@see https://github.com/square/maximum-awesome/blob/master/vimrc

" General Setup.
set autoread							" Reload files when changed on disk.
set autoindent
set smartindent
set backspace=eol,start,indent
set clipboard=unnamed					" Lets you use system clipboard
set encoding=utf-8



" Key Mappings
"   Disable Arrow Keys for HJKL
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"   Enable JK in autocomplete results
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))



" CommandBar and Ruler
set ruler
set cmdheight=1
set cursorline
set number
set laststatus=2						" always show last status
set showcmd
set smartcase							" case-insensitive search if any caps
set wildmenu							" navigable menu for tab completion
set wildmode=longest,list,full


" Word Wrapping w/o Line Break Insertion
set textwidth=0							" These two rules prevent vim from inserting line
set wrapmargin=0						"   line break chars when wrapping.
set wrap linebreak nolist


" Comment Autocompletion
set formatoptions=r


" Find and RegEx
set incsearch
set hlsearch
set ignorecase
set modeline


" Highlight on tabs/EOL spaces
" Whitespace Configuration
"	Tabs and EOL spaces
set ts=4
set sts=4
set shiftwidth=4
set smarttab
set noexpandtab
"set listchars=tab:»·,trail:·
set listchars=tab:`\ ,trail:~,extends:>,precedes:<
set list



" Highlight Tab and Trailing Spaces
hi SpecialKey ctermfg=black
hi ExtraWhitespace ctermfg=red
"hi LineNr ctermfg=black
"hi LineNr ctermbg=black


" Match trailing whitespace, which will get highlighted in red.
" @see http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

" =====================================================================
" SPECIAL SYNTAX HIGHLIGHTING

" Highlight Tagfiles as JSP syntax
au BufNewFile,BufRead *.tag set filetype=jsp

" Setup JSON as a filetype
au BufNewFile,BufRead *.json set filetype=json

" Specialized Tab Settings for Python & JSON
"   Because MUP wants to use tabs rather than spaces, I have to expand
"   tabs to spaces in python. Womp womp.
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79 expandtab
au FileType json set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79 expandtab



" =====================================================================
" PLUGINS

" NerdTree
"	http://www.vim.org/scripts/script.php?script_id=1658
map <C-a> :NERDTreeToggle<CR>

" MatchIt
" XML element open/close matching.
" @see http://www.vim.org/scripts/script.php?script_id=39
runtime macros/matchit.vim

" Powerline/Airline
" @see https://github.com/bling/vim-airline
" @see https://github.com/Lokaltog/powerline-fonts
" @see https://gist.github.com/baopham/1838072 (patched Monaco)
let g:airline_theme='light'			" Theme. See `:help airline`
let g:airline_powerline_fonts=0		" Use powerline font chars.
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_fugitive_prefix = ' '
let g:airline_readonly_symbol = ''
let g:airline_linecolumn_prefix = ''

" Solarized stuff
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized

" =====================================================================
" Cleanup
" For performance purposes, this will clear all matches when closing
"   a window.
if version >= 702
	autocmd BufWinLeave * call clearmatches()
endif

" If you are using a console version of Vim, or dealing
" with a file that changes externally (e.g. a web server log)
" then Vim does not always check to see if the file has been changed.
" The GUI version of Vim will check more often (for example on Focus change),
" and prompt you if you want to reload the file.
"
" There can be cases where you can be working away, and Vim does not
" realize the file has changed. This command will force Vim to check
" more often.
"
" Calling this command sets up autocommands that check to see if the
" current buffer has been modified outside of vim (using checktime)
" and, if it has, reload it for you.
"
" This check is done whenever any of the following events are triggered:
" * BufEnter
" * CursorMoved
" * CursorMovedI
" * CursorHold
" * CursorHoldI
"
" In other words, this check occurs whenever you enter a buffer, move the cursor,
" or just wait without doing anything for 'updatetime' milliseconds.
"
" Normally it will ask you if you want to load the file, even if you haven't made
" any changes in vim. This can get annoying, however, if you frequently need to reload
" the file, so if you would rather have it to reload the buffer *without*
" prompting you, add a bang (!) after the command (WatchForChanges!).
" This will set the autoread option for that buffer in addition to setting up the
" autocommands.
"
" If you want to turn *off* watching for the buffer, just call the command again while
" in the same buffer. Each time you call the command it will toggle between on and off.
"
" WatchForChanges sets autocommands that are triggered while in *any* buffer.
" If you want vim to only check for changes to that buffer while editing the buffer
" that is being watched, use WatchForChangesWhileInThisBuffer instead.
"
command! -bang WatchForChanges                  :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0})
command! -bang WatchForChangesWhileInThisBuffer :call WatchForChanges(@%,  {'toggle': 1, 'autoread': <bang>0, 'while_in_this_buffer_only': 1})
command! -bang WatchForChangesAllFile           :call WatchForChanges('*', {'toggle': 1, 'autoread': <bang>0})
" WatchForChanges function
"
" This is used by the WatchForChanges* commands, but it can also be
" useful to call this from scripts. For example, if your script executes a
" long-running process, you can have your script run that long-running process
" in the background so that you can continue editing other files, redirects its
" output to a file, and open the file in another buffer that keeps reloading itself
" as more output from the long-running command becomes available.
"
" Arguments:
" * bufname: The name of the buffer/file to watch for changes.
"     Use '*' to watch all files.
" * options (optional): A Dict object with any of the following keys:
"   * autoread: If set to 1, causes autoread option to be turned on for the buffer in
"     addition to setting up the autocommands.
"   * toggle: If set to 1, causes this behavior to toggle between on and off.
"     Mostly useful for mappings and commands. In scripts, you probably want to
"     explicitly enable or disable it.
"   * disable: If set to 1, turns off this behavior (removes the autocommand group).
"   * while_in_this_buffer_only: If set to 0 (default), the events will be triggered no matter which
"     buffer you are editing. (Only the specified buffer will be checked for changes,
"     though, still.) If set to 1, the events will only be triggered while
"     editing the specified buffer.
"   * more_events: If set to 1 (the default), creates autocommands for the events
"     listed above. Set to 0 to not create autocommands for CursorMoved, CursorMovedI,
"     (Presumably, having too much going on for those events could slow things down,
"     since they are triggered so frequently...)
function! WatchForChanges(bufname, ...)
  " Figure out which options are in effect
  if a:bufname == '*'
    let id = 'WatchForChanges'.'AnyBuffer'
    " If you try to do checktime *, you'll get E93: More than one match for * is given
    let bufspec = ''
  else
    if bufnr(a:bufname) == -1
      echoerr "Buffer " . a:bufname . " doesn't exist"
      return
    end
    let id = 'WatchForChanges'.bufnr(a:bufname)
    let bufspec = a:bufname
  end
  if len(a:000) == 0
    let options = {}
  else
    if type(a:1) == type({})
      let options = a:1
    else
      echoerr "Argument must be a Dict"
    end
  end
  let autoread    = has_key(options, 'autoread')    ? options['autoread']    : 0
  let toggle      = has_key(options, 'toggle')      ? options['toggle']      : 0
  let disable     = has_key(options, 'disable')     ? options['disable']     : 0
  let more_events = has_key(options, 'more_events') ? options['more_events'] : 1
  let while_in_this_buffer_only = has_key(options, 'while_in_this_buffer_only') ? options['while_in_this_buffer_only'] : 0
  if while_in_this_buffer_only
    let event_bufspec = a:bufname
  else
    let event_bufspec = '*'
  end
  let reg_saved = @"
  "let autoread_saved = &autoread
  let msg = "\n"
  " Check to see if the autocommand already exists
  redir @"
    silent! exec 'au '.id
  redir END
  let l:defined = (@" !~ 'E216: No such group or event:')
  " If not yet defined...
  if !l:defined
    if l:autoread
      let msg = msg . 'Autoread enabled - '
      if a:bufname == '*'
        set autoread
      else
        setlocal autoread
      end
    end
    silent! exec 'augroup '.id
      if a:bufname != '*'
        "exec "au BufDelete    ".a:bufname . " :silent! au! ".id . " | silent! augroup! ".id
        "exec "au BufDelete    ".a:bufname . " :echomsg 'Removing autocommands for ".id."' | au! ".id . " | augroup! ".id
        exec "au BufDelete    ".a:bufname . " execute 'au! ".id."' | execute 'augroup! ".id."'"
      end
        exec "au BufEnter     ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHold   ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHoldI  ".event_bufspec . " :checktime ".bufspec
      " The following events might slow things down so we provide a way to disable them...
      " vim docs warn:
      "   Careful: Don't do anything that the user does
      "   not expect or that is slow.
      if more_events
        exec "au CursorMoved  ".event_bufspec . " :checktime ".bufspec
        exec "au CursorMovedI ".event_bufspec . " :checktime ".bufspec
      end
    augroup END
    let msg = msg . 'Now watching ' . bufspec . ' for external updates...'
  end
  " If they want to disable it, or it is defined and they want to toggle it,
  if l:disable || (l:toggle && l:defined)
    if l:autoread
      let msg = msg . 'Autoread disabled - '
      if a:bufname == '*'
        set noautoread
      else
        setlocal noautoread
      end
    end
    " Using an autogroup allows us to remove it easily with the following
    " command. If we do not use an autogroup, we cannot remove this
    " single :checktime command
    " augroup! checkforupdates
    silent! exec 'au! '.id
    silent! exec 'augroup! '.id
    let msg = msg . 'No longer watching ' . bufspec . ' for external updates.'
  elseif l:defined
    let msg = msg . 'Already watching ' . bufspec . ' for external updates'
  end
"  echo msg
  let @"=reg_saved
endfunction

let autoreadargs={'autoread':1}
execute WatchForChanges("*",autoreadargs)
