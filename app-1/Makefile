# Executables (local)
DOCKER_COMP = docker compose

# Docker containers
PHP_CONT = $(DOCKER_COMP) exec app

# Executables
PHP      = $(PHP_CONT) php
COMPOSER = $(PHP_CONT) composer
SYMFONY  = $(PHP) bin/console

init: ## Copy init files
	mkdir -m 777 -p var

build: ## Builds the Docker images
	@$(DOCKER_COMP) build --pull
.PHONY: build

up: ## Start the docker hub in detached mode (no logs)
	@$(DOCKER_COMP) up --pull always --detach

down: ## Stop the docker hub
	@$(DOCKER_COMP) down --remove-orphans

recreate: down up ## Recreate compose stack

logs: ## Show live logs
	@$(DOCKER_COMP) logs --tail=0 --follow

ash: ## Connect to the PHP container
	@$(PHP_CONT) ash


## —— Composer 🧙 ——————————————————————————————————————————————————————————————
composer: ## Run composer, pass the parameter "c=" to run a given command, example: make composer c='req symfony/orm-pack'
	@$(eval c ?=)
	@$(COMPOSER) $(c)

vendor: ## Install vendors according to the current composer.lock file
vendor: c=install --prefer-dist --no-progress
vendor: composer


## —— Symfony 🎵 ———————————————————————————————————————————————————————————————
sf: ## List all Symfony commands or pass the parameter "c=" to run a given command, example: make sf c=about
	@$(eval c ?=)
	@$(SYMFONY) $(c)

setup: ## Setup project
setup: up vendor migrate

cc: c=cache:clear ## Clear the cache
cc: sf

migrate: ## Run doctrine migrations
migrate: c=doctrine:migrations:migrate -n
migrate: sf
