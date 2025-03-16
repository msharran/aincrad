SHELL := /bin/bash

.PHONY: aincrad/install
aincrad/install:
	git crypt unlock
	stow -v .
	chmod 400 $(HOME)/.ssh/id*

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

# Path to the bootstrap script for Ubuntu ARM64 VMs.
# This script will be copied to the VM and executed during bootstrapping.
BOOTSTRAP_VM_SCRIPT = ./sbin/bootstrap_vm_ubuntu_arm64.sh
BOOTSTRAP_VM_DIR = vm-bootstrap

.PHONY: host/bootstrap
host/bootstrap:
	brew install git-crypt
	make

.PHONY: vm/bootstrap
vm/bootstrap:
	rsync -arP $(BOOTSTRAP_VM_DIR) $(VM_SSH_HOST):~/
	make vm/copy-secrets
	ssh -t $(VM_SSH_HOST) "bash -xe ~/$(BOOTSTRAP_VM_DIR)/bootstrap.sh"

.PHONY: vm/copy-secrets
vm/copy-secrets:
ifeq ($(EXPORTED_GPG_ZIP), undefined)
	@echo "EXPORTED_GPG_ZIP is not defined"
	@exit 1
endif
	rsync -arvP $(EXPORTED_GPG_ZIP) $(VM_SSH_HOST):~/$(BOOTSTRAP_VM_DIR)
	ssh -t $(VM_SSH_HOST) "export EXPORTED_GPG_ZIP=$(shell basename $(EXPORTED_GPG_ZIP)); cd ~/bootstrap; bash -xe import_gpg.sh"
