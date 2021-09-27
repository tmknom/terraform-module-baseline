SHELL := /bin/bash
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.SUFFIXES:
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help

# Variables
DEFAULT_BRANCH ?= main
PROJECT_ROOT := $$(git rev-parse --show-toplevel)
BASIC_DIR := $(PROJECT_ROOT)/examples/basic

# Terraform
plan: ## plan basic
	terraform -chdir=$(BASIC_DIR) init
	terraform -chdir=$(BASIC_DIR) plan

apply: ## apply basic
	terraform -chdir=$(BASIC_DIR) apply

fmt: ## format code
	cd $(PROJECT_ROOT) && terraform fmt -recursive

# Git
.PHONY: merge
merge: ## merge to main branch
	git switch $(DEFAULT_BRANCH)
	git pull --rebase origin $(DEFAULT_BRANCH) 2>/dev/null || true
	$(MAKE) clean

.PHONY: push
push: ## push current branch
	git push origin $$(git rev-parse --abbrev-ref HEAD) -f

.PHONY: clean
clean: ## clean branch
	git branch --merged | grep -v '* main' | xargs git branch -d
	git fetch --prune 2>/dev/null || true

# https://postd.cc/auto-documented-makefile/
help: ## show help
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
