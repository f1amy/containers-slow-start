# Executables (local)
DOCKER_COMP = docker compose

# Services
MARIADB = $(DOCKER_COMP) exec mariadb
MYSQL = $(DOCKER_COMP) exec mysql
REDIS = $(DOCKER_COMP) exec redis

# Application Makefiles
APP_1 = make -C ./app-1

init: ## Init git submodules and copy init files
	@$(APP_1) init


build: ## Builds the Docker images
	@$(DOCKER_COMP) build --pull
	@$(APP_1) build
.PHONY: build

up: ## Start the docker hub in detached mode (no logs)
	@$(DOCKER_COMP) up -d --pull always --wait
	@$(APP_1) up

down: ## Stop the docker hub
	@$(APP_1) down
	@$(DOCKER_COMP) down --remove-orphans

recreate: down up ## Recreate docker hub


## —— Setup services ✨ ———————————————————————————————————————————————————————————————
setup: ## Setup all services
setup: up setup-app-1

setup-app-1: ## Up and build
	@$(APP_1) setup
