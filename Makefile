.PHONY: help
.DEFAULT_GOAL = help

DC=docker-compose
PHP=$(DC) exec php
CONS=$(PHP) bin/console
DB=$(DC) exec db

## —— Docker 🐳  ———————————————————————————————————————————————————————————————
u: up
up: ## docker-compose up -d
	$(DC) up -d

d: down
down: ## docker-compose down
	$(DC) down -v --remove-orphans

r: restart
restart: down up ## docker compose down & up

php: ## Enters the PHP container
	$(PHP) sh

## —— Database 📑 ———————————————————————————————————————————————————————————————
#mysqldump --defaults-extra-file=/path/.sqlpwd [database] > [desiredoutput].sql
#[mysqldump]
#user=username
#password=password
#sudo chmod 600 /path/.sqlpwd && sudo chown $USER:nogroup /path/.sqlpwd

db-dump: ## Backup the database as a SQL backup file (the filename as an argument)
	 $(DB) mysqldump -uroot -proot jpgrammar | sed '1d' > $(filter-out $@,$(MAKECMDGOALS))

db-load: ## Load a SQL backup file (the filename as an argument)
	docker exec -i $$(docker-compose ps -q db) mysql -uroot -proot jpgrammar < $(filter-out $@,$(MAKECMDGOALS)) 2> /dev/null

dm: db-migration
db-migration: ## Run doctrine migrations
	$(CONS) doctrine:migrations:migrate --no-interaction

## —— Tests 🤖 ———————————————————————————————————————————————————————————————
t: test
test: ## Run tests
	$(PHP) bin/phpunit

tc: test-coverage
test-coverage: ## Run tests with code coverage
	$(PHP) bin/phpunit --coverage-html public/code-coverage

td: test-db
test-db:
	$(PHP) rm var/data/test.sqlite
	$(CONS) d:d:c -e test
	$(CONS) d:s:c -e test
	$(CONS) d:f:l -n -e test
	$(PHP) mv var/data/test.sqlite tests/test.sqlite

## —— Others 🛠️️ ———————————————————————————————————————————————————————————————
help: ## Generates this list
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

cs: code-style
code-style: ## Fix code style
	$(PHP) tools/php-cs-fixer/vendor/bin/php-cs-fixer fix src
