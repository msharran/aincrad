SHELL := /bin/bash

.PHONY: install
install:
	git crypt unlock
	stow -v .
	chmod 400 .ssh/id*

.PHONY: ls
ls:
	ls -lhat ~ | grep ^l | grep -w aincrad

.PHONY: dryrun
dryrun:
	stow -v -n .

.PHONY: clean
clean:
	stow -v -D .

.PHONY: vm-install
vm-install: ssh-copy-id
	cd ansible &&\
	ansible-playbook -i inventory.yml site.yml --ask-become-pass

.PHONY: vm-install-aincrad
vm-install-aincrad: ssh-copy-id
	cd ansible &&\
	ansible-playbook -i inventory.yml site.yml --ask-become-pass --tags dotfiles

.PHONY: ssh-copy-id 
ssh-copy-id:
	# Refer .ssh/config file for the Host configuration
	ssh-copy-id -i ~/.ssh/id_msharran.pub vm 
