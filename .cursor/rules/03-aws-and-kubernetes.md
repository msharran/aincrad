---
name: AWS and Kubernetes
description: Profiles and environment setup for kubectl
---

- Use the following only for work repos under ~/root/work
- Use AWS profile `stage-headuser` for stage and `central-headuser` for central.
- Before any `kubectl` commands: `eval $(aws-okta-py env {profile})`.
