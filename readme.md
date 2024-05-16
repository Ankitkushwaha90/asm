### (netwide assembly) nasm installation in kali linux
```bash
sudo apt install nasm
```
### Installation virtual machine x86
```bash
sudo apt install qemu-system-x86
```

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
### maddy code
```asm
global _start

section .text

_start:
  mov rax,1 ;write syscall
  mov rdi,1 ;file Desciptor -> output
  mov rsi,hello ; Buffer -> value
  mov rdx,11 ; number of character to print
  syscall

  ;exit
  mov rax,60 ;exit syscall
  mov rdi,22 ;status code
  syscall

section .data
  hello: db 'hello maddy'
```
