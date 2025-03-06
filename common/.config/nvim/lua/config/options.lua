-- vim.cmd("filetype indent off")

vim.o.exrc = true
-- Base --
vim.o.clipboard = "unnamedplus"
vim.g.encoding = "utf-8"
vim.g.fileencodings = "ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1"
vim.o.history = 1000
vim.o.errorbells = false
vim.o.visualbell = false
vim.o.spell = false
vim.o.backspace = "indent,eol,start"
vim.o.virtualedit = "none"
vim.o.formatoptions = vim.o.formatoptions .. "m" -- 整形オプション，マルチバイト系を追加
-- vim.g.netrw_keepdir = 0

-- File --
vim.o.swapfile = false
vim.o.backup = false
vim.o.hidden = true
vim.o.autoread = true
vim.o.autowrite = true
vim.o.autochdir = false

local undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"
if not vim.fn.isdirectory(undodir) then
  vim.fn.mkdir(undodir, "p", 0770)
end
vim.o.undofile = true
vim.o.undodir = undodir

-- Display --
-- vim.opt.shortmess:append("I") -- disable start message
vim.o.title = true
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cmdheight = 1
vim.o.showmode = false
vim.o.showmatch = true
vim.o.matchtime = 1
vim.o.showcmd = false
vim.o.laststatus = 2
-- vim.o.wildmenu = true
-- vim.o.wildmode = "list:longest,full"
vim.o.scrolloff = 4
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "100"
vim.o.cursorline = true
vim.o.list = true
vim.o.conceallevel = 0
vim.o.concealcursor = ""
vim.opt.listchars = { nbsp = "+", trail = "-", tab = "  " }
-- vim.opt.listchars:append("trail: ")
-- vim.opt.listchars:append("lead:·")
-- vim.opt.listchars:append("space:·")
-- vim.opt.listchars:append("tab:▸ ")

-- Tab & Indent --
vim.o.tabstop = 4 -- only set tabstop
vim.o.shiftwidth = 0 -- tabstopに従う
vim.o.softtabstop = -1 -- shiftwidthに従う
vim.o.expandtab = true -- expand tab to spaces
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.showbreak = "+ "
vim.o.breakindent = true

-- Search --
vim.o.wrapscan = true -- 最後まで検索したら先頭へ戻る
vim.o.ignorecase = true -- 大文字小文字無視
vim.o.smartcase = true -- 大文字ではじめたら大文字小文字無視しない
vim.o.incsearch = true -- インクリメンタルサーチ
vim.o.hlsearch = true -- 検索文字をハイライト
