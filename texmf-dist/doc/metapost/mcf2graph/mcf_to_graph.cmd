rem  Batch file for compile MCF  2023.05.07
rem  rename filename by purpose
rem  <drag and drop library files on this batch>

@echo off
for %%f in (%*) do (
  mkdir %%~nf
  copy %%f temp.mcf

  rem  *** mcf_to_svg  create svg in ./filename (default)
  mpost -output-directory=./%%~nf template_soc.mp

  rem  *** mcf_to_png  create png in ./filename
  rem  mpost -output-directory=./%%~nf -s ahangle=1 template_soc.mp

  rem  *** mcf_to_mol2k  create MOL(V2000) in ./filename
  rem  mpost -output-directory=./%%~nf -s ahlength=5 template_soc.mp

  rem  *** mcf_to_mol3k  create MOL(V3000) in ./filename
  rem  mpost -output-directory=./%%~nf -s ahlength=6 template_soc.mp

  rem  *** mcf_to_report  create report
  rem  mpost -numbersystem=double -s ahlength=7 template_soc.mp

  del temp.mcf
  )
  