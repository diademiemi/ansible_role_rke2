Ansible Role RKE2
=========

[![Molecule Test](https://github.com/diademiemi/ansible_role_rke2/actions/workflows/molecule.yml/badge.svg)](https://github.com/diademiemi/ansible_role_rke2/actions/workflows/molecule.yml)

This is an Ansible role to install and configure rke2.

Include more information about rke2 in this section.

Requirements
------------
These platforms are supported:
- Ubuntu 20.04  
- Ubuntu 22.04  
- Debian 11  
- EL 8 (Tested on Rocky Linux 8)  
- EL 9 (Tested on Rocky Linux 9)  
- Fedora 40  
- openSUSE Leap 15.5

<!--
- List hardware requirements here  
-->

Role Variables
--------------

Variable | Default | Description
--- | --- | ---
`rke2_role_name` | `rke2` | Name of role role in collection Rancher
`rke2_script_url` | `https://get.rke2.io` | URL of the RKE2 setup script
`rke2_channel` | `v1.24` | RKE2 release channel. v1.24 is the latest supported for Rancher
`rke2_tls_san` | `["{{ ansible_domain }}"]` | List of additional domains to add to the RKE2 server certificate
`rke2_type` | `server` | RKE2 type. Options: `[server, agent]`
`rke2_server_token` | ` ` | RKE2 server token to set. Will be generated at runtime if unset.
`rke2_auto_cluster` | `true` | Automatically put all nodes in the current play in a single cluster. Use the first hosts as initial server.
`rke2_server_ip` | ` ` | If this variable is set, nodes will register to this existing server. Must not be set on the initial host.
`rke2_server_ansible_user` | `{{ ansible_user_id }}` | User to copy the kubeconfig to ~/.kube/config
<!--
`variable` | `default` | Variable example
`long_variable` | See [defaults/main.yml](./defaults/main.yml) | Variable referring to defaults
`distro_specific_variable` | See [vars/debian.yml](./vars/debian.yml) | Variable referring to distro-specific variables
-->

Dependencies
------------
<!-- List dependencies on other roles or criteria -->
None

Example Playbook
----------------

```yaml
- name: Use diademiemi.rke2 role
  hosts: "{{ target | default('rke2') }}"
  roles:
    - role: "diademiemi.rke2"
      tags: ['diademiemi', 'rke2', 'setup']    ```

```

License
-------

MIT

Author Information
------------------

- diademiemi (@diademiemi)

Role Testing
------------

This repository comes with Molecule that run in Podman on the supported platforms.
Install Molecule by running

```bash
pip3 install -r requirements.txt
```

Run the tests with

```bash
molecule test
```

These tests are automatically ran by GitHub Actions on push. If the tests are successful, the role is automatically published to Ansible Galaxy.

