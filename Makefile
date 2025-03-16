SHELL := /bin/bash

.PHONY: aincrad
aincrad:
	git crypt unlock
	stow -v .

.PHONY: ls
ls:
	ls -lhat ~ | grep ^l | grep -w aincrad

.PHONY: dryrun
dryrun:
	stow -v -n .

.PHONY: clean
clean:
	stow -v -D .

.PHONY: host/bootstrap
host/bootstrap:
	brew install git-crypt
