# Makefile to build WVU WCRL Beamer Presentations.
#
# == Version History ==
# 
# 	Initial Version - Terry Ferrett 10/5/2010
#
#
# ==== Project directory structure ====
#		bibtex/  	- Bibliography files (.bib)
#
#		build/   	- Latex build files (.aux, .log, .bblm .blg, .pdf)
#
#		figures/ 	- Project figures
#
#		refsPaper/ 	- References related to the project
#
#		styleFiles/	- Latex and Bibtex style files (.cls, .bst, .clo)
#
#		tex/		- Latex source files.
#
#		doc/		- Beamer documentation
#
#
# === Make Build Rules ====
#	  Default:
#		- Run pdflatex over the beamer presentation file defined
#		   by 'FILE_TexMasterFile'
#
#		- Run pdflatex and bibtex over the Latex file containing
#			references, 'FILE_BibMasterFile'
#
#	  Clean:
#		1. Remove all files from the ./build directory
#
#		2. Remove Emacs temporary files (*~) from the entire
#			directory structure
#
#		3. Remove (##) files







############# Files ##############

# Master Presentation file
FILE_TexMasterFile = master



# Master bibliograhy file
FILE_BibMasterFile = bibliography_tex


# Bibliography file
FILE_Bibliography = bibliography

##################################








############## Paths ##############

# Latex source files (.tex)
PATH_TexFiles = ./tex/


# Build directory (.log, .aux, ...)
PATH_build = ./build/


# Bibliographies (.bib)
PATH_bibtex = ./bib/


# Style files (.cls, .bst, .clo)
PATH_styleFiles = ./sty/

###################################










## Get a list of all of the latex source files in this project.  Make will use this
# to conditionally recompile the project, for example:
# 
# Consider a latex project with the following 3 source files:
#  1. ./tex/latex1.tex
#  2. ./tex/latex2.tex
#  3. ./tex/latex3.tex
#
#
#
# Make will track all changes made to these files, and will only compile the files
#  if:
#
#  1. The /build directory is empty
#
#   OR
#
#  2. A change is made to any of the .tex files
#
# The 'wildcard' command dynamically retrieves the list of files
#  in this project, so that the user does not have to edit the makefile
#  manually.
FILE_AllTexFiles := $(wildcard $(PATH_TexFiles)*.tex)









####### Files with full paths ######

# Master Latex file
FULLPATH_TexMasterFile = $(PATH_TexFiles)$(FILE_TexMasterFile).tex


# Master Bibliography file
FULLPATH_TexBibFile = $(PATH_TexFiles)$(FILE_BibMasterFile).tex



# Bibliography
FULLPATH_Bibliography = $(PATH_bibtex)$(FILE_Bibliography).bib

######################################




# TEXINPUTS - environment variable required to configure 'pdflatex' paths
TEXINPUTS := "$(PATH_TexFiles):$(PATH_bibtex):$(PATH_styleFiles):"
#TEXINPUTS := "./styleFiles/:./tex/:./figures/:"












############## Make Rules #############################



###### Build rule ######
# Build the Latex file using pdflatex.
#  Run the following command sequence:
#  
#  1. pdflatex
#  2. bibtex
#  3. bibtex
#  4. pdflatex
#  5. pdflatex
#  6. copy output from ./build/ to root
$(FILE_TexMasterFile).pdf : $(FILE_AllTexFiles)
	# Run LaTeX over presentation
	export TEXINPUTS=$(TEXINPUTS); \
	pdflatex -output-directory $(PATH_build) $(FULLPATH_TexMasterFile)


	# Run LaTeX over presentation
	export TEXINPUTS=$(TEXINPUTS); \
	pdflatex -output-directory $(PATH_build) $(FULLPATH_TexMasterFile)




	# Run LaTeX over bibliography tex file
	export TEXINPUTS=$(TEXINPUTS); \
	pdflatex -output-directory $(PATH_build) $(FULLPATH_TexBibFile)



	# Run BibTeX
	export BSTINPUTS=$(PATH_styleFiles); \
	export BIBINPUTS=$(PATH_bibtex); \
	bibtex $(PATH_build)$(FILE_BibMasterFile)

	# Run BibTeX
	export BSTINPUTS=$(PATH_styleFiles); \
	export BIBINPUTS=$(PATH_bibtex); \
	bibtex $(PATH_build)$(FILE_BibMasterFile)


	# Run LaTeX over bibliography tex file
	export TEXINPUTS=$(TEXINPUTS); \
	pdflatex -output-directory $(PATH_build) $(FULLPATH_TexBibFile)

	# Run LaTeX over bibliography tex file
	export TEXINPUTS=$(TEXINPUTS); \
	pdflatex -output-directory $(PATH_build) $(FULLPATH_TexBibFile)



	# Copy the resulting PDF to the root directory.
	cp $(PATH_build)$(FILE_TexMasterFile).pdf .
	cp $(PATH_build)$(FILE_BibMasterFile).pdf .

	echo $(TexFiles)






######## Clean rule #########
	# - Clear the /build directory

	# - Remove Emacs temporary files

	# - Remove the resulting PDF file from the root directory

	# - Remove "##" files
	#
	# "-" tells make to continue, even if rm returns a nonzero value,
	#	for example, if no files are removed
clean : 

	@-rm ./build/*

	@-find . -iname '*~' | xargs rm

	@-rm $(FILE_TexMasterFile).pdf
	@-rm $(FILE_BibMasterFile).pdf

	@-find . -iname '#*#' | xargs rm


######################################################

