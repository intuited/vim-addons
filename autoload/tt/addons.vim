" Repository of my unpublished addons.
let tt#addons#addons = {
      \ 'categories': ['unpublished'],
      \ 'unpublished': {} }

function! s:RepoInfo(addon_name)
  return vam#install#RewriteName(printf('github:intuited/%s', a:addon_name))
endfunction

call extend(tt#addons#addons.unpublished, {
      \ 'tt_addons': s:RepoInfo('vim-addons'),
      \ 'tt_escape': s:RepoInfo('vim-escape'),
      \ 'tt_path':   s:RepoInfo('vim-path') })

function! tt#addons#addons.UpdateVAM(...)
  let categories = a:0 ? a:000 : self.categories
  for category in categories
    call extend(g:vim_addon_manager.plugin_sources, self[category])
  endfor
endfunction

function! tt#addons#UpdateVAM(...)
  return call(g:tt#addons#addons.UpdateVAM, a:000, g:tt#addons#addons)
endfunction


" Utility functions

function! s:Unique(strings)
  let dict = {}
  for string in strings
    let dict[string] = 1
  endfor
  return keys(dict)
endfunction

function! s:Chain(list)
  let ret = []
  for sublist in list
    call extend(ret, sublist)
  endfor
  return ret
endfunction

