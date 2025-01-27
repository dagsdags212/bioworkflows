#
# Downloads NCBI run information based on a bioproject number
#

# Makefile preamble.
SHELL := bash
.DELETE_ON_ERROR:
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --warn-undefined-variables --no-print-directory

# Absolute path of parent directory.
ROOT_PATH = $(shell dirname $(abspath $(firstword $(MAKEFILE_LIST))))

# Micromamba environment.
ENV = bf-fetch

# Run command within environment.
ENV_RUN = micromamba run -n $(ENV)

# Project number
ID ?= PRJNA257197

# Project runinfo file.
OUT ?= $(ID).csv

# List of accessions from the runinfo file.
ACC_LIST ?= $(ID)_accessions.txt

# General usage information.
help::
	@echo "#"
	@echo "# bioproject.mk: downloads runinfo for an SRA bioproject"
	@echo "#"
	@echo "# ID=PRJNA257197"
	@echo "# OUT=PRJNA257197.csv"
	@echo "#"
	@echo "# make run|get|clean|install"
	@echo "#"

# Project run information.
$(OUT):
	# Create output directory.
	mkdir -p $(dir $@)

	# Retrieve run metadata.
	$(ENV_RUN) bio search $(ID) --header --csv > $@

# Extract accessions from project runinfo.
$(ACC_LIST): $(OUT)
	@cat $< | cut -d, -f1 | tail +2 > $@

# Target to download all the data.
run:: $(OUT) $(ACC_LIST)
	@ls -lh $(OUT) $(ACC_LIST)

# Remove bioproject
run!::
	rm -rf $(OUT) $(ACC_LIST)

# For backward compatibility.
get: run
clean: run!

# Installation instructions
install::
	@echo "pip install bio --upgrade"
