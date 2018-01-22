.PHONY:
pull:
	git pull --recurse-submodules
	git submodule sync --recursive # update URLs contained in .gitmodules
	git submodule update --recursive --init

.PHONY:
aura: empty
	make -C aura img-docker

.PHONY:
run-aura: aura/build/boot.img
	qemu-system-x86_64 -enable-kvm -net none -m 1024 -bios aura/ovmf.fd -usb -usbdevice disk::aura/build/boot.img

.PHONY:
clean:
	make -C aura clean
	
.PHONY:
empty: