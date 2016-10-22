# to speed up compilation incorporate:
# - http://www.alecjacobson.com/weblog/?p=3954
# - http://www.howtotex.com/tag/faster-latex/

@default_files = ('example_assignment');

# Use LuaLateX.
$pdflatex = 'lualatex -file-line-error -interaction=nonstopmode -halt-on-error %O %S';
# LuaLaTeX only produces PDFs.
$pdf_mode = 1;
$postscript_mode = 0;
$dvi_mode = 0;

# Register that .bbl files are regenerable.
$bibtex_use = 2;

# Register that each run also creates a "*.run.xml" file, so it can be cleaned.
push @generated_exts, 'run.xml';
