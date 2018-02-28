# -*- mode: perl; -*-
$pdf_mode = 4; # luaLaTeX
$postscript_mode = $dvi_mode = 0;
$lualatex = 'lualatex --synctex=8 --interaction nonstopmode --file-line-error --halt-on-error %O %S';

# extract git version info before each compile
system('./gitinfo2.sh > gitHeadLocal.gin');

@default_files = ( 'sbabook' );
