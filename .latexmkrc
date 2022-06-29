$pdf_mode = 1;
$xelatex = "xelatex -file-line-error -halt-on-error -interaction=nonstopmode -no-pdf -synctex=1 %O %S";
$xdvipdfmx = "xdvipdfmx -E -o %D %O %S";
$pdflatex = "pdflatex -file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 %O %S";
$bibtex_use = 1.5;
$preview_continuous_mode = 1;
$pdf_previewer = 'SumatraPDF.exe';
