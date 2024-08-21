.section .text
.globl _memcpy

_memcpy:
    testq %rdx, %rdx
    jz .done
.copy_loop:
    movb (%rsi), %al
    movb %al, (%rdi)
    incq %rsi
    incq %rdi
    decq %rdx
    jnz .copy_loop
.done:
    ret

# This is the basic implementation but I need to take some time to implement some data structures more efficient for a proper malloc implementation
# I have to look more but this shit is cool already
.globl _malloc
_malloc:
    movq $0x9, %rax
    movq $0, %rdi
    movq %rdi, %rsi
    movq $0x3, %rdx
    movq $0x22, %r10
    xorq %r8, %r8
    xorq %r9, %r9
    syscall
    ret

.globl _free
_free:
    movq $0xB, %rax
    movq %rdi, %rsi
    syscall
    ret

.globl _realloc
_realloc:
    movq %rsi, %rdx
    movq %rdi, %rsi
    movq %rdx, %rdi
    call _malloc
    movq %rdi, %rsi
    movq %rax, %rdi
    call _memcpy
    movq %rsi, %rsi
    call _free
    ret

.globl _calloc
_calloc:
    mulq %rsi
    call _malloc
    testq %rax, %rax
    jz done
    movq %rdi, %rcx
    xorq %rdi, %rdi
    rep stosb
done:
    ret
