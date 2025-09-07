# ansible/Makefile
PLAYBOOK = site.yml
INVENTORY = inventory.yml

.PHONY: orb vm help create-orb

# Help message
help:
	@echo "Usage: make [target]"
	@echo "  orb/install:        Run playbook on orb machine"
	@echo "  utm/install:        Run playbook on vm machine"
	@echo "  orb/create:         Create a new orb machine with user msharran"

orb/install:
	@read -s -p "Enter GPG passphrase for orb: " GPG_PASSPHRASE; \
	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --limit orb --extra-vars "gpg_passphrase=$$GPG_PASSPHRASE"

utm/install:
	@read -s -p "Enter GPG passphrase for vm: " GPG_PASSPHRASE; \
	ansible-playbook $(PLAYBOOK) -i $(INVENTORY) --limit vm --extra-vars "gpg_passphrase=$$GPG_PASSPHRASE"

orb/create:
	orb create -a arm64 ubuntu -u msharran
