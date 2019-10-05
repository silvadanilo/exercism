	.text
	.file	"lib.cgu-0.rs"
	.section	.text._ZN3lib16hamming_distance17hda0d3eda989316e2E,"ax",@progbits
	.globl	_ZN3lib16hamming_distance17hda0d3eda989316e2E
	.p2align	4, 0x90
	.type	_ZN3lib16hamming_distance17hda0d3eda989316e2E,@function
_ZN3lib16hamming_distance17hda0d3eda989316e2E:
	.cfi_startproc
	pushq	%rbp
.Ltmp0:
	.cfi_def_cfa_offset 16
	pushq	%r14
.Ltmp1:
	.cfi_def_cfa_offset 24
	pushq	%rbx
.Ltmp2:
	.cfi_def_cfa_offset 32
.Ltmp3:
	.cfi_offset %rbx, -32
.Ltmp4:
	.cfi_offset %r14, -24
.Ltmp5:
	.cfi_offset %rbp, -16
	cmpq	%r8, %rdx
	jne	.LBB0_1
	xorl	%r10d, %r10d
	testq	%rdx, %rdx
	je	.LBB0_35
	leaq	(%rsi,%rdx), %r8
	addq	%rcx, %rdx
	xorl	%r10d, %r10d
	.p2align	4, 0x90
.LBB0_4:
	leaq	1(%rsi), %rbp
	movzbl	(%rsi), %r9d
	testb	%r9b, %r9b
	js	.LBB0_6
	movq	%rbp, %rsi
	jmp	.LBB0_19
	.p2align	4, 0x90
.LBB0_6:
	xorl	%eax, %eax
	cmpq	%r8, %rbp
	movq	%r8, %rbx
	je	.LBB0_8
	movzbl	1(%rsi), %eax
	addq	$2, %rsi
	andl	$63, %eax
	movq	%rsi, %rbx
.LBB0_8:
	movl	%r9d, %r11d
	andl	$31, %r11d
	cmpb	$-32, %r9b
	jb	.LBB0_9
	xorl	%ebp, %ebp
	cmpq	%r8, %rbx
	movq	%r8, %rsi
	je	.LBB0_12
	movzbl	(%rbx), %ebp
	incq	%rbx
	andl	$63, %ebp
	movq	%rbx, %rsi
.LBB0_12:
	shll	$6, %eax
	orl	%ebp, %eax
	cmpb	$-16, %r9b
	jb	.LBB0_13
	xorl	%ebx, %ebx
	cmpq	%r8, %rsi
	je	.LBB0_16
	movzbl	(%rsi), %ebx
	incq	%rsi
	andl	$63, %ebx
.LBB0_16:
	andl	$7, %r11d
	shll	$18, %r11d
	shll	$6, %eax
	orl	%ebx, %eax
	jmp	.LBB0_17
.LBB0_9:
	shll	$6, %r11d
	orl	%r11d, %eax
	movq	%rbx, %rsi
	jmp	.LBB0_18
.LBB0_13:
	shll	$12, %r11d
.LBB0_17:
	orl	%r11d, %eax
.LBB0_18:
	movl	%eax, %r9d
.LBB0_19:
	cmpq	%rdx, %rcx
	je	.LBB0_35
	leaq	1(%rcx), %rax
	movzbl	(%rcx), %ebx
	testb	%bl, %bl
	jns	.LBB0_34
	xorl	%r11d, %r11d
	cmpq	%rdx, %rax
	movq	%rdx, %rax
	je	.LBB0_23
	movzbl	1(%rcx), %r11d
	addq	$2, %rcx
	andl	$63, %r11d
	movq	%rcx, %rax
.LBB0_23:
	movl	%ebx, %ecx
	andl	$31, %ecx
	cmpb	$-32, %bl
	jb	.LBB0_24
	xorl	%ebp, %ebp
	cmpq	%rdx, %rax
	movq	%rdx, %r14
	je	.LBB0_27
	movzbl	(%rax), %ebp
	incq	%rax
	andl	$63, %ebp
	movq	%rax, %r14
.LBB0_27:
	shll	$6, %r11d
	orl	%ebp, %r11d
	cmpb	$-16, %bl
	jb	.LBB0_28
	xorl	%eax, %eax
	cmpq	%rdx, %r14
	je	.LBB0_31
	movzbl	(%r14), %eax
	incq	%r14
	andl	$63, %eax
.LBB0_31:
	andl	$7, %ecx
	shll	$18, %ecx
	shll	$6, %r11d
	orl	%eax, %r11d
	jmp	.LBB0_32
.LBB0_24:
	shll	$6, %ecx
	orl	%ecx, %r11d
	jmp	.LBB0_33
.LBB0_28:
	shll	$12, %ecx
.LBB0_32:
	orl	%ecx, %r11d
	movq	%r14, %rax
.LBB0_33:
	movl	%r11d, %ebx
.LBB0_34:
	xorl	%ecx, %ecx
	cmpl	%ebx, %r9d
	setne	%cl
	addl	%ecx, %r10d
	cmpq	%r8, %rsi
	movq	%rax, %rcx
	jne	.LBB0_4
.LBB0_35:
	movl	$0, (%rdi)
	movl	%r10d, 4(%rdi)
	jmp	.LBB0_36
.LBB0_1:
	movl	$1, (%rdi)
	leaq	str8399(%rip), %rax
	movq	%rax, 8(%rdi)
	movq	$35, 16(%rdi)
.LBB0_36:
	movq	%rdi, %rax
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end0:
	.size	_ZN3lib16hamming_distance17hda0d3eda989316e2E, .Lfunc_end0-_ZN3lib16hamming_distance17hda0d3eda989316e2E
	.cfi_endproc

	.type	str8399,@object
	.section	.rodata.str8399,"a",@progbits
	.p2align	4
str8399:
	.ascii	"sequences must have the same length"
	.size	str8399, 35


	.section	".note.GNU-stack","",@progbits
