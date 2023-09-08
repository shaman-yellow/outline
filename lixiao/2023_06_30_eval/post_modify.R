# ==========================================================================
# render as report
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_articlePdf("index.Rmd", "output.Rmd", "Results of Molecular Docking\nauthor: Huang Lichuang in Wie-Biotech")

file.copy("./output.pdf", "eval.pdf", T)

package_results(head = NULL, masterZip = NULL)


