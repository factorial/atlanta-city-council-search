.PHONY: help
help: show-help

.PHONY: start-local
start-local: containers-start              ## start up all services on localhost

.PHONY: stop-local            
stop-local:                                ## stop all services on localhost
	docker-compose down

.PHONY: shell-api
shell-api:                                 ## shell into the api continer
	docker-compose exec api bash

.PHONY: local-db-cli
local-db-cli:                              ## connect to psql cli
	docker-compose exec -e POSTGRES_PASSWORD=atlcc db psql -U atlcc -d atlcc

.PHONY: local-db-migrate
local-db-migrate:                          ## run rake db:migrate
	docker-compose exec api rake db:migrate

.PHONY: local-db-seed
local-db-seed:                             ## run rake db:seed
	docker-compose exec api rake db:seed

.PHONY: containers-start
containers-start:
	docker-compose build
	docker-compose up -d

.PHONY: show-help
show-help:
	@grep -E '^[1-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-24s\033[0m %s\n", $$1, $$2}'
