; hello_world_bootloader.asm
BITS 16                    ; We are using 16-bit real mode for the bootloader
ORG 0x7C00                 ; BIOS loads the bootloader at address 0x7C00

START:
    ; Print "Hello, World!" message using BIOS interrupt
    mov ah, 0x0E           ; BIOS teletype function (prints character in AL)
    mov al, 'H'            ; Load 'H' into AL
    int 0x10               ; Call BIOS interrupt to print the character

    mov al, 'e'            ; Load 'e' into AL
    int 0x10               ; Print 'e'

    mov al, 'l'            ; Load 'l' into AL
    int 0x10               ; Print 'l'

    mov al, 'l'            ; Load 'l' into AL
    int 0x10               ; Print 'l'

    mov al, 'o'            ; Load 'o' into AL
    int 0x10               ; Print 'o'

    mov al, ','            ; Load ',' into AL
    int 0x10               ; Print ','

    mov al, ' '            ; Load ' ' (space) into AL
    int 0x10               ; Print space

    mov al, 'W'            ; Load 'W' into AL
    int 0x10               ; Print 'W'

    mov al, 'o'            ; Load 'o' into AL
    int 0x10               ; Print 'o'

    mov al, 'r'            ; Load 'r' into AL
    int 0x10               ; Print 'r'

    mov al, 'l'            ; Load 'l' into AL
    int 0x10               ; Print 'l'

    mov al, 'd'            ; Load 'd' into AL
    int 0x10               ; Print 'd'

    mov al, '!'            ; Load '!' into AL
    int 0x10               ; Print '!'

    ; Infinite loop to keep the system running
hang:
    jmp hang               ; Loop forever to stop further execution

times 510 - ($ - $$) db 0  ; Pad the rest of the sector with zeroes
dw 0xAA55                  ; Boot sector signature (required for BIOS)
