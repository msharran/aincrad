SHELL := /bin/bash

.PHONY: aincrad/install
aincrad/install:
	git crypt unlock
	stow -v .

.PHONY: aincrad/ls
aincrad/ls:
	ls -lhat ~ | grep ^l | grep -w aincrad

.PHONY: aincrad/dryrun
aincrad/dryrun:
	stow -v -n .

.PHONY: aincrad/clean
aincrad/clean:
	stow -v -D .

# File path to the zip file downloaded
# that contains exported gpg keys
EXPORTED_GPG_ZIP ?= undefined
BOOTSTRAP_VM_SCRIPT = ./sbin/bootstrap_vm_ubuntu_arm64.sh

.PHONY: host/bootstrap
host/bootstrap:
	brew install git-crypt
	make

.PHONY: vm/bootstrap
vm/bootstrap:
	make vm/copy-secrets
	rsync -arP $(BOOTSTRAP_VM_SCRIPT) $(VM_SSH_HOST):~/$(BOOTSTRAP_VM_SCRIPT)
	ssh $(VM_SSH_HOST) "bash ~/$(BOOTSTRAP_VM_SCRIPT)"

vm/copy-secrets:
ifeq ($(EXPORTED_GPG_ZIP), undefined)
	@echo "EXPORTED_GPG_ZIP is not defined"
	@exit 1
endif
	rsync -arvP $(EXPORTED_GPG_ZIP) ./sbin/export_gpg.sh $(VM_SSH_HOST):~/export_gpg.sh
	ssh $(VM_SSH_HOST) "bash ~/export_gpg.sh"
