docker-build:
	@-docker rmi rust-oxide-server:latest
	docker build -t rust-oxide-server:latest ./

docker-export:
	@-rm ./build/rust-oxide-server.tar
	docker save rust-oxide-server:latest > ./build/rust-oxide-server.tar

docker-import:
	@-docker rmi rust-oxide-server:latest
	docker load < ./build/rust-oxide-server.tar

docker-test:
	docker run --rm \
		--network host \
		--name rust-oxide-server-test \
		-e SERVER_HOST_IP="127.0.0.1" \
		-e SERVER_HOST_PORT="28015" \
		-e SERVER_WORLD_SIZE="2000" \
		-e ADMIN_STEAMID="12345678909876543" \
		-e ADMIN_NAME="AdminNickName" \
		-v /etc/timezone:/etc/timezone:ro \
		-it rust-oxide-server:latest

docker-push:
	docker login
	docker tag rust-oxide-server zombaksteam/rust-oxide-server:latest
	docker push zombaksteam/rust-oxide-server:latest
	docker rmi zombaksteam/rust-oxide-server:latest
	docker rmi rust-oxide-server:latest
