.PHONY:
x86_64-unknown-efi:
	docker build -t projectasiago/rustbuildenv:x86_64-unknown-efi . -f Dockerfile.x86_64-unknown-efi
	docker run -it --rm -e LOCAL_UID="$(shell id -u)" -e LOCAL_GID="$(shell id -g)" -v aura-"$(shell id -u)-$(shell id -g)"-cargo:/usr/local/cargo -v $(shell pwd)/..:/usr/src/asiago -w /usr/src/asiago projectasiago/rustbuildenv:x86_64-unknown-efi bash

.PHONY:
linux:
	docker build -t projectasiago/rustbuildenv:linux . -f Dockerfile.linux
	docker run -it --rm -e LOCAL_UID="$(shell id -u)" -e LOCAL_GID="$(shell id -g)" -v aura-"$(shell id -u)-$(shell id -g)"-cargo:/usr/local/cargo -v $(shell pwd)/..:/usr/src/asiago -w /usr/src/asiago projectasiago/rustbuildenv:linux bash