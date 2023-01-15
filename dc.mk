test: ## Test with Docker Compose
	docker-compose up

clean: docker-compose-clean

docker-compose-clean: ## Clean Docker Compose
	docker rm es01 kibana --force
	docker volume prune --force
	docker network prune --force

.PHONY: test docker-compose-clean
