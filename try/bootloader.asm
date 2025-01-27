; Filename: bootloader.asm
; Assemble with: nasm -f bin bootloader.asm -o bootloader.bin
; Test with: qemu-system-x86_64 -drive format=raw,file=bootloader.bin

BITS 16                   ; We are in real mode (16-bit mode)
ORG 0x7C00                ; BIOS loads bootloader here in memory

start:
    cli                   ; Disable interrupts
    xor ax, ax            ; Clear AX register
    mov ds, ax            ; Set data segment to 0
    mov es, ax            ; Set extra segment to 0
    mov ss, ax            ; Set stack segment to 0
    mov sp, 0x7C00        ; Set stack pointer to 0x7C00

    ; Print a message
    mov si, hello_message ; Point to the message
    call print_string     ; Call subroutine to print the string

    ; Halt the CPU (infinite loop)
hang:
    hlt                   ; Halt instruction
    jmp hang              ; Jump back to hang

; Subroutine to print a string
print_string:
    mov ah, 0x0E          ; BIOS teletype output function
next_char:
    lodsb                 ; Load next character from DS:SI into AL
    cmp al, 0             ; Check if the character is null (end of string)
    je done               ; If null, end the subroutine
    int 0x10              ; Call BIOS interrupt to print character
    jmp next_char         ; Repeat for the next character
done:
    ret                   ; Return to the caller

; Data
hello_message db "Hello, Bootloader World!", 0

; Boot signature (must be at offset 510-511 in the bootloader)
times 510-($-$$) db 0    ; Fill the remaining bytes with zeros
dw 0xAA55                ; Boot signature (magic number)

