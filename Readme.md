# x86_64 Assembly Language Examples

## 1. Basic Arithmetic Operations

### Addition and Subtraction
```asm
section .text
    global _start

_start:
    mov rax, 10           ; Load 10 into RAX
    add rax, 20           ; Add 20 to RAX (RAX = 30)
    sub rax, 5            ; Subtract 5 from RAX (RAX = 25)

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall
```

### Multiplication and Division
```asm
section .text
    global _start

_start:
    mov rax, 6            ; Load 6 into RAX
    mov rbx, 7            ; Load 7 into RBX
    imul rbx              ; Multiply RAX by RBX (RAX = 42)

    mov rax, 42           ; Load 42 into RAX
    mov rbx, 5            ; Load 5 into RBX
    cqo                   ; Extend RAX into RDX for division
    idiv rbx              ; Divide RAX by RBX (RAX = 8, RDX = 2)

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall
```

## 2. Data Movement

### Moving Data Between Registers
```asm
section .text
    global _start

_start:
    mov rax, 100          ; Load 100 into RAX
    mov rbx, rax          ; Copy value from RAX to RBX

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall
```

### Memory Access
```asm
section .data
    value dq 12345        ; Define a 64-bit value

section .text
    global _start

_start:
    mov rax, [value]      ; Load the value at `value` into RAX
    mov [value], 67890    ; Store 67890 into `value`

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall
```

## 3. Conditional Logic

### Compare and Jump
```asm
section .text
    global _start

_start:
    mov rax, 10           ; Load 10 into RAX
    cmp rax, 5            ; Compare RAX with 5
    jl less_than          ; Jump if less than
    jg greater_than       ; Jump if greater than

equal:
    ; Handle equal case
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall

less_than:
    ; Handle less than case
    mov eax, 60
    mov edi, 1            ; Exit code 1
    syscall

greater_than:
    ; Handle greater than case
    mov eax, 60
    mov edi, 2            ; Exit code 2
    syscall
```

## 4. Loops

### Simple Loop
```asm
section .text
    global _start

_start:
    mov rcx, 5            ; Set loop counter to 5

loop_start:
    dec rcx               ; Decrement RCX
    jnz loop_start        ; Jump if not zero

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall
```

## 5. String Operations

### Copying Strings
```asm
section .data
    source db 'Hello, World!', 0
    destination db 13 dup(0)

section .text
    global _start

_start:
    mov rsi, source       ; Source address
    mov rdi, destination  ; Destination address
    mov rcx, 13           ; Number of bytes to copy
    rep movsb             ; Copy bytes

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall
```

### Finding a Character
```asm
section .data
    string db 'Find this character: X', 0
    char_to_find db 'X'

section .text
    global _start

_start:
    mov rdi, string       ; String address
    mov al, char_to_find  ; Character to find
    mov rcx, 22           ; String length
    repne scasb           ; Search for the character

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall
```

## 6. Function Calls

### Calling a Simple Function
```asm
section .text
    global _start

_start:
    mov rdi, 5            ; First argument
    mov rsi, 10           ; Second argument
    call add_numbers      ; Call the function

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall

add_numbers:
    add rdi, rsi          ; RDI = RDI + RSI
    mov rax, rdi          ; Return result in RAX
    ret
```

## 7. System Calls

### Write to Standard Output
```asm
section .data
    message db 'Hello from Assembly!', 0

section .text
    global _start

_start:
    mov rax, 1            ; sys_write
    mov rdi, 1            ; File descriptor (stdout)
    mov rsi, message      ; Message to write
    mov rdx, 21           ; Length of message
    syscall               ; Perform system call

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall
```

### Reading Input
```asm
section .bss
    buffer resb 20        ; Reserve 20 bytes for input

section .text
    global _start

_start:
    mov rax, 0            ; sys_read
    mov rdi, 0            ; File descriptor (stdin)
    mov rsi, buffer       ; Buffer to store input
    mov rdx, 20           ; Number of bytes to read
    syscall               ; Perform system call

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall
```

## 8. Floating-Point Operations

### Using SIMD Registers
```asm
section .data
    a dq 1.5, 2.5
    b dq 3.0, 4.0
    result dq 0.0, 0.0

section .text
    global _start

_start:
    movaps xmm0, [a]      ; Load values from `a`
    movaps xmm1, [b]      ; Load values from `b`
    addps xmm0, xmm1      ; Perform parallel addition
    movaps [result], xmm0 ; Store the result

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall
```

## 9. Multi-Threading

### Thread Creation (Linux syscall)
```asm
section .text
    global _start

_start:
    mov rax, 56           ; sys_clone (create a thread)
    mov rdi, 0x502        ; Flags for clone (CLONE_VM | CLONE_FS)
    mov rsi, 0            ; Child stack
    syscall               ; Create thread

    ; Exit program
    mov eax, 60           ; sys_exit
    xor edi, edi          ; Exit code 0
    syscall
```

## 10. Interrupt Handling

### Using Software Interrupts
```asm
section .text
    global _start

_start:
    mov eax, 1            ; sys_exit (Linux syscall)
    xor ebx, ebx          ; Exit code 0
    int 0x80              ; Trigger software interrupt
```
