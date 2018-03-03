.PHONY:
pull:
	git pull --recurse-submodules
	git submodule sync --recursive # update URLs contained in .gitmodules
	git submodule update --recursive --init

.PHONY:
clean:
	make -C aura clean
	make -C mish-linux clean
	make -C mish clean
	make -C feta clean

.PHONY:
empty: