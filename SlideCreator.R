#import libraries
require(pdftools) #converts pdf slide show to jpegs
require(glue) #allow for naming

#Saves you a headache
print("Is your working directory set to the folder where you site is housed?")
#Asks for the name of the folder where the slides will be housed
directory <- readline(prompt = "What is the name of the folder with the slides?")
#Asks for the name of the pdf of slide deck. Do not include .pdf in your response.
pdf_name <- readline(promp = "What is the name of the pdf?")

#gets current directroy
cur_wd <- getwd()
#creates the file path to the directory 
directory_path <- glue("{cur_wd}/content/slides/{directory}")
#creates the file path to the pdf
file_path <- glue("{directory_path}/slides/{pdf_name}.pdf")


#sets working directory so the pdf to jpeg function exports to the right place
setwd(directory_path)
#converts pdf to jpeg, let's you know that it's working via verbose
pdf_convert(file_path, format = "jpeg", pages = NULL,
            filenames = NULL, dpi = 300, opw = "", upw = "", verbose = TRUE)

#how long is the slide show 
deck_length <- pdf_length(file_path)
#yaml header for index.md
header <- "---
authors: 
categories: []
date: 
slides: 
  highlight_style: dracula
  theme: black
summary: 
title:
---"

#initialize deck
deck <- ""
#creates and appends the code to display the slides
for (i in 1:deck_length){
  slide_name <- glue("{pdf_name}_{i}")
  slide <- glue('\n\n{{{{< slide background-image="./slides/{slide_name}.jpeg" >}}}}\n___\n')
  deck <- paste0(c(deck, slide))
}

#saves thß slide deck as index.md
cat(header, deck, file = "index.md", sep = c(""))
#resets working directory
setwd(cur_wd)