.PHONY:
pull:
	git pull --recurse-submodules
	git submodule sync --recursive # update URLs contained in .gitmodules
	git submodule update --recursive --init

.PHONY:
aura: empty
	make -C aura

.PHONY:
mish: empty
	make -C mish

.PHONY:
run-aura:
	qemu-system-x86_64 -enable-kvm -net none -m 1024 -bios aura/ovmf.fd -usb -usbdevice disk::aura/build/boot.img

.PHONY:
buildenv:
	make -C rustbuildenv
	docker run -it --rm -e LOCAL_UID="$(shell id -u)" -e LOCAL_GID="$(shell id -g)" -v aura-"$(shell id -u)-$(shell id -g)"-cargo:/usr/local/cargo -v $(shell pwd):/usr/src/asiago -w /usr/src/asiago projectasiago/rustbuildenv:latest bash

.PHONY:
clean:
	make -C aura clean
	make -C mish clean
	make -C feta clean
	
.PHONY:
empty: