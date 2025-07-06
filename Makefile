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

