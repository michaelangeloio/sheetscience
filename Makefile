D := $(shell pwd)


build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

stop:
	docker-compose stop

reset:
	docker-compose restart

bash:
	docker-compose exec app bash

logs:
	docker-compose logs
