# Celox
Celox is a hobbyist kernel, focused on being fast and speedy. 

## Prerequisites
- xorriso
- grub-pc-bin
- mtools
- qemu-system
- nasm
- GNU Make 

## How to build
```sh
git clone https://github.com/g4iliunas/celox.git
cd celox
mkdir build bin
make
```
The produced ISO should be generated in `bin` directory.

## TODO
- [ ] Proper logging (serial with `DEBUG` preprocessor)
- [ ] GDT
- [ ] IDT
- [ ] Memory management
    - [ ] PMM
    - [ ] VMM
- more...