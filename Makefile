install:
	bash install.sh

start:
	docker-compose up

.PHONY: clean

clean:
	rm -rfv data/pgdata data/minio_root/.minio.sys && docker-compose rm -fsv