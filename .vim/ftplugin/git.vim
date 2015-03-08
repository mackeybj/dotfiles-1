" ==============================================================================
" = git ftplugin                                                               =
" ==============================================================================

" if fugitive is available...

if exists('g:loaded_fugitive')
	" have <c-]> over a git hash/tag/etc do a "git show" on it
	nnoremap <c-]> "*yiw:FTStackPush<cr>:Git! show <c-r>*<cr>
	" pop tag stack
	nnoremap <buffer> <c-t>        :FTStackPop<cr>
endif