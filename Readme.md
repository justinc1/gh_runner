# About

A helper playbook to setup multiple github runners.

Plan:
- create new VM
- setup docker in new VM
- start 0 to N github runners in the VM


# Commands

```
cat ansible.cfg  # check content
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
ansible-galaxy collection install -r requirements.yml
ansible-galaxy role install -r requirements.yml

# check content
cat vars/vars.yml
cat files/ubuntu2004-cloud-init-user-date.yml
```

```
ansible-playbook -i hypercore_inventory.yml -e @vars/vars.yml p0_upload_iso.yml -v
ansible-playbook -i hypercore_inventory.yml -e @vars/vars.yml p1_create_vm.yml -v

ansible-inventory -i hypercore_inventory.yml --list
ansible-playbook -i hypercore_inventory.yml -e @vars/vars.yml -l xlab-runner-ub2004 p2_install_docker.yml -v
# PERSONAL_ACCESS_TOKEN - see https://github.com/MonolithProjects/ansible-github_actions_runner
PERSONAL_ACCESS_TOKEN=... ansible-playbook -i hypercore_inventory.yml -e @vars/vars.yml -l xlab-runner-ub2004 p3_install_github_runner.yml -e runner_ind=0 -v 
```
