" slightly modified code sample from the:
" http://learnvimscriptthehardway.stevelosh.com/chapters/49.html

setlocal foldmethod=expr
setlocal foldexpr=GetPythonFold(v:lnum)

fun! s:NextNonBlankLine(lnum)"{{{
  let numlines = line('$')
  let current = a:lnum + 1

  while current <= numlines
    if getline(current) =~? '\v\S'
      return current
    endif

    let current += 1
  endwhile

  return -2
endfun
"}}}

fun! s:IndentLevel(lnum)"{{{
  return indent(a:lnum) / &shiftwidth
endfun
"}}}

fun! GetPythonFold(lnum)"{{{
  if getline(a:lnum) =~? '\v^\s*$'
    " '=' = fold blanks, '-1' = don't fold blanks
    return '='
  endif

  let this_indent = <SID>IndentLevel(a:lnum)
  let next_indent = <SID>IndentLevel(<SID>NextNonBlankLine(a:lnum))

  if next_indent == this_indent
    return this_indent
  elseif next_indent < this_indent
    return this_indent
  elseif next_indent > this_indent
    return '>' . next_indent
  endif
endfun
"}}}
" vim: set sw=2 sts=2 et fdm=marker:
