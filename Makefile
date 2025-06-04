#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_NAME = rag-wiki
PYTHON_VERSION = 3.12
PYTHON_INTERPRETER = python

#################################################################################
# COMMANDS                                                                      #
#################################################################################


## Create a virtual environment with the specified Python version
.PHONY: install
install:
	poetry install --no-root

## Create data dirs structure
.PHONY: create-data-dirs
create-data-dirs:
	mkdir -p data/processed
	mkdir -p data/raw
	mkdir -p data/interim


## Format source code with black
.PHONY: format
format:
	black notebooks/*.ipynb


#################################################################################
# PROJECT RULES                                                                 #
#################################################################################



#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys; \
lines = '\n'.join([line for line in sys.stdin]); \
matches = re.findall(r'\n## (.*)\n[\s\S]+?\n([a-zA-Z_-]+):', lines); \
print('Available rules:\n'); \
print('\n'.join(['{:25}{}'.format(*reversed(match)) for match in matches]))
endef
export PRINT_HELP_PYSCRIPT

help:
	@$(PYTHON_INTERPRETER) -c "${PRINT_HELP_PYSCRIPT}" < $(MAKEFILE_LIST)
