# Asiago

## Dependencies
 - Docker (for building)
 - Make (for running scripts)
 - QEMU (for Aura execution)
 - that's it!

## Getting
```
$ git clone --recurse-submodules git@github.com:projectasiago/asiago.git
```

## Building

The easiest way to build is to build inside the Docker image. To enter this image, run this command:
```
$ cd buildenv && make linux
```
Once inside the container, you can build like so:
```
$ make mish-linux
```

## Running
```
$ make run-aura
```