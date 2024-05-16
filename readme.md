### (netwide assembly) nasm installation in kali linux
```bash
sudo apt install nasm
```
### Installation virtual machine x86
```bash
sudo apt install qemu-system-x86
```
```bash
qemu-system-x86_64
```
### source code of hello world 
```asm
ORG 0x7c00
BITS 16

start:
  mov si, message
  call print
  jmp $

print:
  mov bx, 0
.loop:
  lodsb
  cmp al, 0
  je .done
  call print_char
  jmp .loop
.done:
  ret

print_char:
  mov ah, 0eh
  int 0x10
  ret

message: db 'Hello World!', 0

times 510-($ - $$) db 0
dw 0xAA55
```
### compalie asm 
```bash
nasm -f bin ./boot.asm -o ./boot.bin
```
### run on virtual system qemu
```bash
qemu-system-x86_64 -hda ./boot.bin
```
- successfully run on qemu-system-x86_64 
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
