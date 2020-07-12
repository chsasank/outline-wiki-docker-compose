env.outline env.minio:
	@bash generate_conf.sh create_env_files

data/certs/private.key:
	@bash generate_conf.sh create_env_files

.PHONY: clean install start

install: env.outline env.minio
	@echo "=>run 'docker-compose up -d' and your server should be ready shortly."

install-https: data/certs/private.key

start: env.outline env.minio
	docker-compose up -d

logs:
	docker-compose logs -f

stop:
	docker-compose down

clean-docker:
	docker-compose rm -fsv || true

clean-conf:
	rm -rfv data/certs/* env.*

clean-data:
	rm -rfv data/pgdata data/minio_root/.minio.sys

clean: clean-docker clean-conf clean-data