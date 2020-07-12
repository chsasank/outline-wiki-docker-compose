install:
	bash install.sh

start:
	docker-compose up

.PHONY: clean

clean:
	docker-compose rm -fsv && rm -rfv data/pgdata data/minio_root/.minio.sys