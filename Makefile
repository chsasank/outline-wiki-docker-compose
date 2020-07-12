env.outline env.minio:
	@bash generate_conf.sh create_env_files

data/certs/dhparam.pem:
	mkdir -p data/certs
	openssl dhparam -out data/certs/dhparam.pem 2048

data/certs/private.key data/certs/public.crt: env.outline data/certs/dhparam.pem
	@bash generate_conf.sh generate_starter_https_conf

env.slack: env.outline
	@bash generate_conf.sh create_slack_env

.PHONY: clean install start

https: data/certs/private.key
	@echo "=>run 'make start' and your server should be ready shortly."

init-data-dirs: env.outline
	@bash generate_conf.sh init_data_dirs

install: env.outline env.minio env.slack init-data-dirs
	@echo "=>run 'make start' and your server should be ready shortly."

start: install
	docker-compose up -d

logs:
	docker-compose logs -f

stop:
	docker-compose down || true

clean-docker: stop
	docker-compose rm -fsv || true

clean-conf:
	rm -rfv data/certs/* env.*
	rm -rf data/minio_root/.minio.sys/

clean-data:
	@bash generate_conf.sh delete_data

clean: clean-docker clean-conf