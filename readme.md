### (netwide assembly) nasm installation in kali linux
```bash
apt install nasm
```
### Installation virtual machine x86
```bash
nasm -f elf64 maddy.asm -o maddy.o
```
### linker assembly
```bash
ld --help
```
```bash
ld maddy.o -o maddy
```

