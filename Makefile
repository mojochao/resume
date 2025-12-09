# ==============================================================================
# Build shell
# ==============================================================================

# Setting SHELL to bash allows bash commands to be executed by recipes.
# Options are set to exit when a recipe line exits non-zero or a piped command fails.
SHELL = /usr/bin/env bash -o pipefail
.SHELLFLAGS = -ec

# Show help by default
.DEFAULT_GOAL := help

# ==============================================================================
# Build variables
# ==============================================================================

ROOT_DIR   ?= $(PWD)
BUILD_DIR  ?= $(ROOT_DIR)/build
SOURCE_DIR ?= $(ROOT_DIR)/src

NODE_MODULES_DIR = $(ROOT_DIR)/node_modules
NODE_BIN_DIR     = $(NODE_MODULES_DIR)/.bin

JSONRESUME_BUILDER_BIN ?= resume
JSONRESUME_BUILDER_PKG ?= resume-cli
JSONRESUME_THEME_PKG   ?= modern-classic

source   ?= resume.json
format   ?= txt
filename ?= resume

# ==============================================================================
# Build targets
# ==============================================================================

# The default help target prints out all targets with their descriptions within
# their categories. The categories are defined by '##@' and the target
# descriptions by '##'. The `awk` command is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

##@ Info targets

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: vars
vars: ## Show environment variables used by this Makefile
	@echo "ROOT_DIR:                $(ROOT_DIR)"
	@echo "BUILD_DIR:               $(BUILD_DIR)"
	@echo "SOURCE_DIR:              $(SOURCE_DIR)"
	@echo "NODE_MODULES_DIR:        $(NODE_MODULES_DIR)"
	@echo "NODE_BIN_DIR:            $(NODE_BIN_DIR)"
	@echo "JSONRESUME_BUILDER_BIN:  $(JSONRESUME_BUILDER_BIN)"
	@echo "JSONRESUME_BUILDER_PKG:  $(JSONRESUME_BUILDER_PKG)"
	@echo "JSONRESUME_THEME_PKG:    $(JSONRESUME_THEME_PKG)"
	@echo "source:                  $(source)"
	@echo "format:                  $(format)"
	@echo "filename:                $(filename)"

##@ Toolchain targets

.PHONY: tools-init
tools-init: ## Initialize resume toolchain
	@echo "Initializing resume toolchain ..."
	@mkdir -p $(BUILD_DIR)
	@npm install $(JSONRESUME_BUILDER_PKG)
	@npm install $(JSONRESUME_THEME_PKG)
	@echo "Done."

.PHONY: tools-update
tools-update: ## Update resume toolchain
	@echo "Updating resume toolchain ..."
	@echo "Done."

.PHONY: tools-clean
tools-clean: ## Clean resume toolchain
	@echo "Cleaning resume toolchain ..."
	@rm -rf $(NODE_MODULES_DIR)
	@echo "Done."

##@ Build targets

.PHONY: check
check: ## Check resume source for errors
	@echo "Checking resume source ..."
	@$(JSONRESUME_BUILDER_BIN) validate 
	@echo "Done."

.PHONY: clean
clean: ## Clean resume builds
	@echo "Cleaning all resume builds ..."
	@rm -rf $(BUILD_DIR)/*
	@echo "Done"

.PHONY: html
html: ## Build resume html
	@echo "Building resume html ..."
	@echo "Done."

.PHONY: pdf
pdf: ## Build resume pdf
	@echo "Building resume pdf ..."
	@echo "Done."
