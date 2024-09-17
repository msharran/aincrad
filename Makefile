.PHONY: setup
setup:
	stow -v .

.PHONY: ls
ls:
	ls -lhat ~ | grep -w .dotfiles

.PHONY: dryrun
dryrun:
	stow -v -n .

.PHONY: clean
clean:
	stow -v -D .
