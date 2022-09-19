set number
set relativenumber
set tabstop=4
set shiftwidth=4
set autoindent
set mouse=a
colorscheme default

if has('win32')
	let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
	let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
	let &shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
	let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	set shellquote= shellxquote=

endif