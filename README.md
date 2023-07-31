Ansible Role Template
=========

[![Molecule Test](https://github.com/diademiemi/ansible_role_template/actions/workflows/molecule.yml/badge.svg)](https://github.com/diademiemi/ansible_role_template/actions/workflows/molecule.yml)

This is an Ansible role to install and configure template.

Include more information about template in this section.

Requirements
------------
These platforms are supported:
- Ubuntu 20.04  
- Ubuntu 22.04  
- Debian 10  
- Debian 11  
- EL 8 (Tested on Rocky Linux 8)  
- EL 9 (Tested on Rocky Linux 9)  
- Fedora 38  
- openSUSE Leap 15.4

<!--
- List hardware requirements here  
-->

Role Variables
--------------

Variable | Default | Description
--- | --- | ---
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
- name: Use diademiemi.template role
  hosts: "{{ target | default('template') }}"
  roles:
    - role: "diademiemi.template"
      vars:
        __role_action: "setup"  # Variable to control which tasks are ran
        # __role_action: "upstream"  # Delegate to role from upstream provider
      tags: ['diademiemi', 'template', 'setup']    ```

```

License
-------

MIT

Author Information
------------------

- diademiemi (@diademiemi)

Role Testing
------------

This repository comes with Molecule tests for Docker on the supported platforms.
Install Molecule by running

```bash
pip3 install -r requirements.txt
```

Run the tests with

```bash
molecule test
```

These tests are automatically ran by GitHub Actions on push. If the tests are successful, the role is automatically published to Ansible Galaxy.

Role Structure
--------------

Roles have an entrypoint `main.yml` which includes other files.  
For every file in `vars/`, `tasks/assert/` that matches the host these vars will be imported and assertions will be ran. For `tasks/setup` only the file most closely resembling the host will ran. If other tasks are necessary they can be included. If no file is found, it falls back to `default.yml`.  

A variable `__role_action` can be used to change the path from `tasks/setup`. This can be useful when tasks should be run to revert the steps from the role or include a role from an upstream collection (E.g. including the Checkmk collection `tribe29.checkmk.agent` role instead of one's own). This can also be a list to chain these together (E.g. include preparation/post-setup tasks around the upstream role).  

Please see [tasks/upstream/default.yml](./tasks/upstream/default.yml) for an example on how to include an upstream role.  

This is an easy way to provide distro-specific variables, assertions and tasks and allows me to keep the role structure clean.  

GitHub Actions is supposed to fail for this template repository, as it does not contain any meaningful role. There is an explicit assertion to check if the role name has been changed from `template` which causes the test to fail.  

Using Template
--------------
To use this template for a new role, run


```bash
export NEW_ROLE_NAME="NEW_NAME"
export GITHUB_USER="diademiemi"
export GALAXY_API_KEY="YOUR_API_KEY"

find . -type f -exec sed -i "s/diademiemi/${GITHUB_USER}/g" {} + # Do not run this more than once
find . -type f -exec sed -i "s/template/${NEW_ROLE_NAME}/g" {} + # Do not run this more than once

# Assumes repo is named ansible_role_${NEW_ROLE_NAME}
gh secret set GALAXY_API_KEY -R ${GITHUB_USER}/ansible_role_${NEW_ROLE_NAME} -a actions -b ${GALAXY_API_KEY}

# Remove this section from README.md
sed -i "/Role Structure/Q" README.md
```

This is also provided as a script as `replace.sh`.  
