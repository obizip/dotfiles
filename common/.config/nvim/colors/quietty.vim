source $VIMRUNTIME/colors/vim.lua " Nvim: revert to Vim default color scheme
let g:colors_name = 'quietty'

let s:t_Co = &t_Co

" 90: #E5E5E5
" 80: #CCCCCC
" 70: #B2B2B2
" 60: #999999
" 50: #7F7F7F
" 40: #666666
" 30: #4C4C4C
" 20: #333333
" 10: #191919

hi Normal       guifg=#E5E5E5 guibg=NONE    gui=NONE    cterm=NONE
hi Comment      guifg=#999999 guibg=NONE    gui=NONE    cterm=NONE
hi Search       guifg=#ffaf00 guibg=NONE gui=NONE    cterm=NONE
hi CurSearch    guifg=#ffaf00 guibg=NONE    gui=reverse cterm=reverse
hi Visual       guifg=NONE    guibg=#424242 gui=NONE    cterm=NONE
"hi CursorLine   guifg=NONE    guibg=#252525 gui=NONE    cterm=NONE
hi CursorLine   guifg=NONE    guibg=NONE gui=NONE    cterm=NONE
hi LineNr       guifg=#666666 guibg=NONE    gui=NONE    cterm=NONE
hi CursorLineNr guifg=#CCCCCC guibg=NONE    gui=NONE    cterm=NONE
hi Pmenu        guifg=NONE    guibg=#191919 gui=NONE    cterm=NONE
hi ColorColumn  guifg=NONE    guibg=#191919 gui=NONE    cterm=NONE
hi Constant     guifg=#FFE6B2 guibg=NONE    gui=NONE    cterm=NONE


hi! link Boolean           Constant
hi! link Character         Constant
hi! link Float             Constant
hi! link Number            Constant
hi! link Type              Normal
hi! link StorageClass      Normal
hi! link Structure         Normal
hi! link String            Constant

hi! link Statement         Normal
hi! link Conceal           Normal
hi! link Conditional       Normal
hi! link Cursor            Normal
hi! link CursorColumn      CursorLine
hi! link CursorIM          Normal
hi! link Debug             Normal
hi! link Define            Normal
hi! link Delimiter         Comment
hi! link DiffAdd           Normal
hi! link DiffChange        Normal
hi! link DiffDelete        Normal
hi! link DiffText          Normal
hi! link Directory         Normal
hi! link EndOfBuffer       Comment
hi! link Error             Normal
hi! link ErrorMsg          Normal
hi! link Exception         Normal
hi! link FoldColumn        Normal
hi! link Folded            Normal
hi! link Function          Normal
hi! link Identifier        Normal
hi! link Ignore            Normal
hi! link IncSearch         Search
hi! link Include           Normal
hi! link Keyword           Comment
hi! link Label             Normal
hi! link Macro             Normal
hi! link MatchParen        Normal
hi! link MessageWindow     Normal
hi! link ModeMsg           Normal
hi! link MoreMsg           Normal
hi! link NonText           Comment
hi! link Operator          Normal
hi! link PmenuExtra        Normal
hi! link PmenuExtraSel     Visual
hi! link PmenuKind         Normal
hi! link PmenuKindSel      Visual
hi! link PmenuSbar         Normal
hi! link PmenuSel          CurSearch
hi! link PmenuThumb        Normal
hi! link PopupNotification Normal
hi! link PreCondit         Normal
hi! link PreProc           Normal
hi! link Question          Normal
hi! link QuickFixLine      Normal
hi! link Repeat            Normal
hi! link SignColumn        Normal
hi! link Special           Normal
hi! link SpecialChar       Normal
hi! link SpecialComment    Comment
hi! link SpecialKey        Comment
hi! link SpellBad          Normal
hi! link SpellCap          Normal
hi! link SpellLocal        Normal
hi! link SpellRare         Normal
hi! link StatusLine        Normal
hi! link StatusLineNC      Normal
hi! link StatusLineTerm    Normal
hi! link StatusLineTermNC  Normal
hi! link TabLine           Normal
hi! link TabLineFill       Normal
hi! link TabLineSel        Normal
hi! link Tag               Normal
hi! link Terminal          Normal
hi! link Title             Normal
hi! link Todo              Normal
hi! link ToolbarButton     Normal
hi! link ToolbarLine       Normal
hi! link Typedef           Normal
hi! link Underlined        Normal
hi! link VertSplit         Normal
hi! link VisualNOS         Normal
hi! link WarningMsg        Normal
hi! link WildMenu          Normal
hi! link debugBreakpoint   Normal
hi! link debugPC           Normal
hi! link lCursor           Normal

" Treesitter
"hi! link @type             Constant
"hi! link @type.builtin     Constant
"hi! link @type.definition  Constant
"hi! link @keyword.type     Constant
"hi! link @keyword.modifier Constant
"hi! link @keyword.operator Operator

"hi! link @keyword.return Type
hi TreesitterContext                 guifg=NONE guibg=NONE gui=NONE      cterm=NONE
hi TreesitterContextBottom           guifg=NONE guibg=NONE gui=underline cterm=NONE
hi TreesitterContextLineNumberBottom guifg=NONE guibg=NONE gui=underline cterm=NONE

" LSP
hi DiagnosticHint  guifg=#1971FF guibg=NONE gui=bold cterm=bold
hi DiagnosticInfo  guifg=#00B06B guibg=NONE gui=bold cterm=bold
hi DiagnosticWarn  guifg=#F6AA00 guibg=NONE gui=bold cterm=bold
hi DiagnosticError guifg=#FF4B00 guibg=NONE gui=bold cterm=bold

"hi DiagnosticUnderlineHint  guisp=#1971FF gui=undercurl
"hi DiagnosticUnderlineInfo  guisp=#00B06B gui=undercurl
"hi DiagnosticUnderlineWarn  guisp=#F6AA00 gui=undercurl
"hi DiagnosticUnderlineError guisp=#FF4B00 gui=undercurl

"hi! link @lsp.type Type
"hi! link @lsp.typemod.macro.globalScope.c Statement
"hi! link @lsp.typemod.namespace Normal
hi @markup.list.markdown guifg=#CCE3FF guibg=NONE gui=bold cterm=bold
hi @markup.heading guifg=#D8CCFF guibg=NONE gui=bold cterm=bold

" Telescope
hi TelescopeMatching guifg=#FF4B00 guibg=NONE gui=bold cterm=bold

" Mini
hi MiniIndentscopeSymbol guifg=#333333 guibg=NONE gui=bold cterm=bold

hi Directory guifg=#15ff00 guibg=NONE gui=bold cterm=bold
