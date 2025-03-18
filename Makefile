SHELL := /bin/bash

.PHONY: aincrad/install
aincrad/install:
	git crypt unlock
	stow -v .
	chmod 400 .ssh/id*

.PHONY: aincrad/ls
aincrad/ls:
	ls -lhat ~ | grep ^l | grep -w aincrad

.PHONY: aincrad/dryrun
aincrad/dryrun:
	stow -v -n .

.PHONY: aincrad/clean
aincrad/clean:
	stow -v -D .

# SSH "Host" added in ~/.ssh/config.
# This is already configured in my ssh config.
# But IP has to be configured when changing the VM
VM_SSH_HOST ?= vm

# File path to the zip file downloaded
# that contains exported gpg keys
EXPORTED_GPG_ZIP ?= undefined

# # The SSH host name.
# If 'VM_SSH_HOST' is not defined or empty, use 'vm' as the default value
VM_SSH_HOST ?= vm

BOOTSTRAP_DIR = bootstrap

.PHONY: host/bootstrap
host/bootstrap:
	@if ! command -v git-crypt &> /dev/null; then \
		brew install git-crypt; \
	fi
	bash -e ./$(BOOTSTRAP_DIR)/import_gpg.sh
	make

.PHONY: vm/bootstrap
vm/bootstrap:
	rsync -arP $(BOOTSTRAP_DIR) $(VM_SSH_HOST):~/
	make vm/copy-secrets
	ssh -t $(VM_SSH_HOST) "bash -e \$$HOME/$(BOOTSTRAP_DIR)/vm.sh"

.PHONY: vm/copy-secrets
vm/copy-secrets:
ifeq ($(EXPORTED_GPG_ZIP), undefined)
	@echo "EXPORTED_GPG_ZIP is not defined"
	@exit 1
endif
	rsync -arvP $(EXPORTED_GPG_ZIP) $(VM_SSH_HOST):~/$(BOOTSTRAP_DIR)
	ssh -t $(VM_SSH_HOST) "export EXPORTED_GPG_ZIP=\$$HOME/$(BOOTSTRAP_DIR)/$(shell basename $(EXPORTED_GPG_ZIP)); cd \$$HOME/$(BOOTSTRAP_DIR);  bash -e import_gpg.sh"
