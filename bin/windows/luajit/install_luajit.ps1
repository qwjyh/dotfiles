# installing luajit under %localappdata%\Programs

# download and build
git clone https://luajit.org/git/luajit.git
cd luajit
make

# installing
$luajit_location = Join-Path $env:LOCALAPPDATA "Programs\luajit"
mkdir $luajit_location
cp .\src\luajit.exe, .\src\lua51.dll $luajit_location
mkdir $luajit_location\lua
mkdir $luajit_location\lua\jit
cp .\src\jit\* $luajit_location\lua\jit

# add to path
while($true) {
  $input = Read-Host "add $env:LOCALAPPDATA\Programs\luajit to `$PATH. (Y)"
  if ($input = 'Y') {
	break
  }
}
