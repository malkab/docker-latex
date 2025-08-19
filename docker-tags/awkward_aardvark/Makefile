# ¡ATENCIÓN! Esto hay que cambiarlo también en el FROM del Dockerfile.
# Nombre de la imagen base, nombre:tag.
BASE_IMAGE_NAME=debian_devcontainer:bookworm
# Nombre de la imagen, nombre:tag.
IMAGE_TAG=tl2025
IMAGE_NAME=latex:$(IMAGE_TAG)
IMAGE_SAVE_NAME=latex_$(IMAGE_TAG)
# Nombre del usuario dentro de la imagen.
IMAGE_USER=vscode

# Para el push a registros privados, especialmente el Gitea.
PUSH_OWNER=whateveruser
PUSH_REGISTRY=a.gitea.com
PUSH_REGISTRY_URL=https://$(PUSH_REGISTRY)

# Atajos.
GIT_COMMIT=$(shell git rev-parse --short=6 HEAD)

LAST_SAVED_VERSION=$(shell \
	find . -maxdepth 1 -type f \
		-name '*.tar.gz' \
		-printf '%T@ %p\n' | \
	sort -nr | \
	head -n1 | \
	cut -d' ' -f2-)

# Ejecuta la imagen base para depurar.
base_image_run:
	@docker run -ti --rm \
		-v $(shell pwd):$(shell pwd) \
		--workdir $(shell pwd) \
		--entrypoint /bin/bash \
		$(BASE_IMAGE_NAME)

# Creación de la imagen base de instalación.
base_installation_image:
	@docker build -f Dockerfile \
		-t latex_manual_install:$(IMAGE_TAG) .

# Montar la ISO.
iso_mount:
	@mkdir -p texlive_mount_point

	@sudo mount assets/texlive/texlive_$(IMAGE_TAG).iso \
    	./texlive_mount_point

# Crea y ejecuta el contenedor no efímero para la instalación del
# TeX Live.
manual_install:
	@docker run -ti \
    	--name latex_install_container_$(IMAGE_TAG) \
	    -v $(shell pwd):/ext \
		-v ./texlive_mount_point/:/texlive \
		-p 8000:8000 \
		latex_manual_install:$(IMAGE_TAG)

# Arranca el contenedor no efímero de la instalación.
run_manual_install:
	@docker start -ai \
		latex_install_container_$(IMAGE_TAG)

# Hace commit de la imagen de instalación manual.
commit:
	@docker commit \
		latex_install_container_$(IMAGE_TAG) \
		$(IMAGE_NAME)

# Ejecuta la imagen construída.
run:
	@docker run -ti --rm \
		--user $(IMAGE_USER):$(IMAGE_USER) \
		-v $(shell pwd):$(shell pwd) \
		--workdir $(shell pwd) \
		$(IMAGE_NAME)

# Subida.
push:
	-@echo "Subiendo imagen $(IMAGE_NAME) a $(PUSH_REGISTRY_URL), no olvidar hacer primero login"

	-@docker tag \
		$(IMAGE_NAME) \
		$(PUSH_REGISTRY)/$(PUSH_OWNER)/$(IMAGE_NAME)

	-@docker push \
		$(PUSH_REGISTRY)/$(PUSH_OWNER)/$(IMAGE_NAME)

# Respaldo a tar.gz de la imagen.
save:
	@docker image save latex:$(IMAGE_TAG) | gzip > \
		$(IMAGE_SAVE_NAME)_$(GIT_COMMIT).tar.gz

# Eliminar activos.
clean:
	@# Drop install-base container
	-@docker rm latex_install_container_$(IMAGE_TAG)

	@# Drop the install-base image
	-@docker rmi latex_manual_install:$(IMAGE_TAG)

	@# Unmount texlive_mount_point
	-@sudo umount ./texlive_mount_point
	-@rmdir ./texlive_mount_point

# Refresca la imagen con el hash actual del GIT
ifneq ($(strip $(LAST_SAVED_VERSION)),)
update_save:
	-@mv $(LAST_SAVED_VERSION) \
		$(IMAGE_SAVE_NAME)_$(GIT_COMMIT).tar.gz
endif
