" addons.vim
" Author: Ted Tibbetts
" License: Licensed under the same terms as Vim itself.
" Adds repo locations for my personal addons to VAM's database.

" The main use of this addon is provided by this function.
" It adds info on the specified set of addons to VAM's repository database.
" The parameter list defaults to all categories known to this addon.
" Those categories are named in the list |tt#addons#addons.categories|.
function! tt#addons#UpdateVAM(...)
  return call(g:tt#addons#addons.UpdateVAM, a:000, g:tt#addons#addons)
endfunction


let tt#addons#addons = {
      \ 'categories': ['unpublished'],
      \ 'unpublished': {} }

function! s:RepoInfo(addon_name)
  return vam#install#RewriteName(printf('github:intuited/%s', a:addon_name))
endfunction

call extend(tt#addons#addons.unpublished, {
      \ 'tt_addons':  s:RepoInfo('vim-addons'),
      \ 'tt_escape':  s:RepoInfo('vim-escape'),
      \ 'tt_path':    s:RepoInfo('vim-path'),
      \ 'testutils':  s:RepoInfo('vim-testutils'),
      \ 'shell_complete': s:RepoInfo('vim-shell_complete'),
      \ 'reput':      s:RepoInfo('vim-reput'),
      \ 'UT':         s:RepoInfo('lh-vim-ut'),
      \ 'lh-vim-lib': s:RepoInfo('lh-vim-lib') })

function! tt#addons#addons.UpdateVAM(...)
  let categories = a:0 ? a:000 : self.categories
  for category in categories
    call extend(g:vim_addon_manager.plugin_sources, self[category])
  endfor
endfunction
