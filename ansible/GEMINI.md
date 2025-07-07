This Ansible playbook bootstraps a Ubuntu ARM VM for development. It installs a variety of tools and configures the system for a specific user, `msharran`.

### Playbook Details:

- **`site.yml`**: The main playbook file. It defines the tasks to be executed on the target VM.
- **`inventory.yml`**: The inventory file, which defines the target host (`vm`) and its connection details.
- **`ansible.cfg`**: The Ansible configuration file, which sets default values for various settings.

### Key Tasks:

- Verifies that the Ubuntu version is 22.04 or higher.
- Installs system dependencies using `apt`.
- Installs various tools using `snap`, including `nvim`, `go`, `node`, `kubectl`, `k9s`, and `stern`.
- Installs Rust, Zig, Jujutsu, and pyenv.
- Configures `npm` to use a global directory within the user's home.
- Installs global npm packages: `@google/gemini-cli` and `@anthropic-ai/claude-code`.
- Installs Starship as the shell prompt.
- Sets Fish as the default shell.
- Clones the `aincrad` repository and installs dotfiles.
- Verifies the installation of all the tools.
