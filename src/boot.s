BITS 32

section .text
    ALIGN 4
    DD 0xBADB002
    DD 0x0000000
    DD -(0x1BADB002 + 0)

global start
extern kernel_main

start:
    CLI
    MOV esp, stack_space
    CALL kernel_main
    HLT
HaltKernel:
    CLI
    HLT
    JMP HaltKernel
section .bss
RESB 8192
stack_space: