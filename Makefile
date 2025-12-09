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
OUTPUT_DIR ?= out
SOURCE_DIR ?= src

# Both of the `jsonschema` and `jsonresume` dependencies use Node.js
NODE_MODULES_DIR = node_modules
NODE_BIN_DIR     = $(NODE_MODULES_DIR)/.bin

# The `resume` command is used to generate the resume outputs.
# See https://github.com/rbardini/resumed for details.
JSONRESUME_CLI_BIN   ?= $(NODE_BIN_DIR)/resume
JSONRESUME_CLI_PKG   ?= resume-cli

# We need to install a theme for `resume` to use.
JSONRESUME_THEME_PKG ?= modern-classic

# The JSON Resume schema is used to validate resume source files.
JSONRESUME_SCHEMA_FILE ?= $(SOURCE_DIR)/schema.json

# The `jsonschema` command is used to validate resume source files.
# See https://github.com/sourcemeta/jsonschema for details.
JSONSCHEMA_CLI_BIN ?= $(NODE_BIN_DIR)/jsonschema
JSONSCHEMA_CLI_PKG ?= @sourcemeta/jsonschema

# Build targets take the following optional arguments.
source_file   ?= $(SOURCE_DIR)/resume.json
output_format ?= html
output_file   ?= $(OUTPUT_DIR)/resume.$(output_format)

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
	@echo "OUTPUT_DIR:              $(OUTPUT_DIR)"
	@echo "SOURCE_DIR:              $(SOURCE_DIR)"
	@echo "NODE_MODULES_DIR:        $(NODE_MODULES_DIR)"
	@echo "NODE_BIN_DIR:            $(NODE_BIN_DIR)"
	@echo "JSONRESUME_CLI_BIN:      $(JSONRESUME_CLI_BIN)"
	@echo "JSONRESUME_CLI_PKG:      $(JSONRESUME_CLI_PKG)"
	@echo "JSONRESUME_THEME_PKG:    $(JSONRESUME_THEME_PKG)"
	@echo "JSONSCHEMA_CLI_BIN:      $(JSONSCHEMA_CLI_BIN)"
	@echo "JSONSCHEMA_CLI_PKG:      $(JSONSCHEMA_CLI_PKG)"
	@echo "source_file:             $(source_file)"
	@echo "output_file:             $(output_file)"
	@echo "output_format:           $(output_format)"

##@ Toolchain targets

.PHONY: tools-init
tools-init: ## Initialize resume toolchain
	@echo "Initializing resume toolchain ..."
	@mkdir -p $(OUTPUT_DIR)
	@npm install $(JSONRESUME_CLI_PKG)
	@npm install $(JSONRESUME_THEME_PKG)
	@npm install $(JSONSCHEMA_CLI_PKG)
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
	@$(JSONSCHEMA_CLI_BIN) validate $(JSONRESUME_SCHEMA_FILE) $(source_file)
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
