; hello_world.asm

BITS 16                    ; Set processor to 16-bit mode
ORG 0x7C00                 ; Origin address (BIOS loads bootloader here)

START:
    ; Print "Hello, World!" using BIOS interrupt 0x10 (teletype mode)
    mov ah, 0x0E           ; BIOS teletype function (print character in AL)
    lea si, message        ; Load the address of the message into SI
    
print_char:
    lodsb                  ; Load the next byte (character) into AL
    or al, al              ; Check if it's the null terminator
    jz hang                ; If zero (null terminator), jump to hang
    int 0x10               ; Otherwise, print the character
    jmp print_char         ; Repeat for the next character

hang:
    jmp hang               ; Infinite loop to prevent further execution

message db 'Hello, World!', 0  ; Null-terminated string

times 510 - ($ - $$) db 0  ; Fill the rest of the sector with zeros
dw 0xAA55                  ; Boot sector signature (required for bootloader)
