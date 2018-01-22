.PHONY:
pull:
	git pull --recurse-submodules
	git submodule sync --recursive # update URLs contained in .gitmodules
	git submodule update --recursive --init

aura: aura/build/boot.img
aura/build/boot.img:
	docker build -t projectasiago/aura.build ./aura
	docker run -it --rm \
		-e LOCAL_UID="$(shell id -u)" -e LOCAL_GID="$(shell id -g)" \
		-v "$(shell pwd)/aura":/usr/src/aura \
		-w /usr/src/aura projectasiago/aura.build \
		make img

.PHONY:
run-aura: aura
	qemu-system-x86_64 -enable-kvm -net none -m 1024 -bios aura/ovmf.fd -usb -usbdevice disk::aura/build/boot.img
	
.PHONY:
clean:
	make -C aura clean