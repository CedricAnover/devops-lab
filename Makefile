DOCKER_SUBNET=172.18.0.0/16

all: deploy

# Deploy Infrastructure
deploy:
	@echo "Deploying infrastructure..."
	@echo "Creating Docker Network 'devops-net' ..."
	@docker network rm devops-net 2>/dev/null || true
	@docker network create --subnet=$(DOCKER_SUBNET) devops-net
	@ansible-playbook -i inventory.yml ./playbooks/localhost_controller/vagrant_up.yml

# Test Ansible by Ping
test:
	@echo "Testing Hosts ..."
	@if [ -z "$(hosts)" ]; then ansible -i inventory.yml all -m ping; fi
	@if [ -n "$(hosts)" ]; then ansible -i inventory.yml $(hosts) -m ping; fi

# Destroy Infrastructure
destroy:
	@echo "Destroying infrastructure..."
	@ansible-playbook -i inventory.yml ./playbooks/localhost_controller/vagrant_destroy.yml
	@echo "Cleaning Docker Network 'devops-net'"
	@docker network rm devops-net 2>/dev/null || true

# Help
help:
	@echo "Available commands:"
	@echo "  make deploy   - Deploy the infrastructure"
	@echo "  make destroy  - Destroy the infrastructure"
	@echo "  make test     - Test Ansible (Usage: make test [hosts=<ansible_group>])"
