# Ad-hoc Commands

## SSH
```bash
# Generate New SSH Key Pair
ssh-keygen -t rsa -b 4096 -f ./.ssh/id_rsa -C "admin@controller" -N ""

# Manual Provisioning of SSH Public Key to System Containers
ssh-copy-id -i '.ssh/id_rsa.pub' admin@$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' server-1)

# SSH to System Container
ssh admin@$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' server-1) -p 22
# When Sysbox Image is provisioned with SSH Public Key. Without Password Prompt.
ssh -i './.ssh/id_rsa' admin@$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' server-1) -p 22
```

## Docker
```bash
```

## Vagrant
```bash
# Deploy
vagrant up --no-parallel

# Destroy
vagrant destroy -f
```
