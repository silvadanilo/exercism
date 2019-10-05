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
	pushq	%r15
.Ltmp1:
	.cfi_def_cfa_offset 24
	pushq	%r14
.Ltmp2:
	.cfi_def_cfa_offset 32
	pushq	%r13
.Ltmp3:
	.cfi_def_cfa_offset 40
	pushq	%r12
.Ltmp4:
	.cfi_def_cfa_offset 48
	pushq	%rbx
.Ltmp5:
	.cfi_def_cfa_offset 56
	subq	$24, %rsp
.Ltmp6:
	.cfi_def_cfa_offset 80
.Ltmp7:
	.cfi_offset %rbx, -56
.Ltmp8:
	.cfi_offset %r12, -48
.Ltmp9:
	.cfi_offset %r13, -40
.Ltmp10:
	.cfi_offset %r14, -32
.Ltmp11:
	.cfi_offset %r15, -24
.Ltmp12:
	.cfi_offset %rbp, -16
	movq	%rcx, 8(%rsp)
	cmpq	%r8, %rdx
	jne	.LBB0_38
	movq	%rdi, 16(%rsp)
	xorl	%r9d, %r9d
	testq	%rdx, %rdx
	je	.LBB0_37
	leaq	(%rsi,%rdx), %rcx
	addq	8(%rsp), %rdx
	xorl	%r9d, %r9d
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB0_3:
	leaq	1(%rsi), %rax
	movzbl	(%rsi), %r10d
	testb	%r10b, %r10b
	js	.LBB0_5
	movq	%rax, %rsi
	jmp	.LBB0_19
	.p2align	4, 0x90
.LBB0_5:
	xorl	%ebx, %ebx
	cmpq	%rcx, %rax
	movq	%rcx, %rbp
	je	.LBB0_7
	movzbl	1(%rsi), %ebx
	addq	$2, %rsi
	andl	$63, %ebx
	movq	%rsi, %rbp
.LBB0_7:
	movl	%r10d, %eax
	andl	$31, %eax
	cmpb	$-32, %r10b
	jb	.LBB0_10
	xorl	%edi, %edi
	cmpq	%rcx, %rbp
	je	.LBB0_11
	movzbl	(%rbp), %edi
	incq	%rbp
	andl	$63, %edi
	movq	%rbp, %rsi
	jmp	.LBB0_12
.LBB0_10:
	shll	$6, %eax
	orl	%eax, %ebx
	movq	%rbp, %rsi
	jmp	.LBB0_18
.LBB0_11:
	movq	%rbp, %rsi
	movq	%rcx, %rbp
.LBB0_12:
	shll	$6, %ebx
	orl	%edi, %ebx
	cmpb	$-16, %r10b
	jb	.LBB0_16
	xorl	%edi, %edi
	cmpq	%rcx, %rbp
	je	.LBB0_15
	movzbl	(%rbp), %edi
	incq	%rbp
	andl	$63, %edi
	movq	%rbp, %rsi
.LBB0_15:
	andl	$7, %eax
	shll	$18, %eax
	shll	$6, %ebx
	orl	%edi, %ebx
	jmp	.LBB0_17
.LBB0_16:
	shll	$12, %eax
.LBB0_17:
	orl	%eax, %ebx
.LBB0_18:
	movl	%ebx, %r10d
.LBB0_19:
	leaq	1(%r14), %r11
	movq	$-1, %rbx
	movq	8(%rsp), %rbp
	.p2align	4, 0x90
.LBB0_20:
	cmpq	%rdx, %rbp
	je	.LBB0_40
	leaq	1(%rbp), %r8
	movzbl	(%rbp), %eax
	testb	%al, %al
	jns	.LBB0_35
	xorl	%r12d, %r12d
	cmpq	%rdx, %r8
	movq	%rdx, %r8
	je	.LBB0_24
	movzbl	1(%rbp), %r12d
	addq	$2, %rbp
	andl	$63, %r12d
	movq	%rbp, %r8
.LBB0_24:
	movl	%eax, %r15d
	andl	$31, %r15d
	cmpb	$-32, %al
	jb	.LBB0_31
	xorl	%edi, %edi
	cmpq	%rdx, %r8
	movq	%rdx, %r13
	je	.LBB0_27
	movzbl	(%r8), %edi
	incq	%r8
	andl	$63, %edi
	movq	%r8, %r13
.LBB0_27:
	shll	$6, %r12d
	orl	%edi, %r12d
	cmpb	$-16, %al
	jb	.LBB0_32
	xorl	%eax, %eax
	cmpq	%rdx, %r13
	je	.LBB0_30
	movzbl	(%r13), %eax
	incq	%r13
	andl	$63, %eax
.LBB0_30:
	andl	$7, %r15d
	shll	$18, %r15d
	shll	$6, %r12d
	orl	%eax, %r12d
	jmp	.LBB0_33
.LBB0_31:
	shll	$6, %r15d
	orl	%r15d, %r12d
	jmp	.LBB0_34
.LBB0_32:
	shll	$12, %r15d
.LBB0_33:
	orl	%r15d, %r12d
	movq	%r13, %r8
.LBB0_34:
	movl	%r12d, %eax
.LBB0_35:
	incq	%rbx
	cmpq	%r14, %rbx
	movq	%r8, %rbp
	jne	.LBB0_20
	xorl	%edi, %edi
	cmpl	%eax, %r10d
	setne	%dil
	addl	%edi, %r9d
	cmpq	%rcx, %rsi
	movq	%r11, %r14
	jne	.LBB0_3
.LBB0_37:
	movq	16(%rsp), %rdi
	movl	$0, (%rdi)
	movl	%r9d, 4(%rdi)
	jmp	.LBB0_39
.LBB0_38:
	movl	$1, (%rdi)
	leaq	str8372(%rip), %rax
	movq	%rax, 8(%rdi)
	movq	$35, 16(%rdi)
.LBB0_39:
	movq	%rdi, %rax
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB0_40:
	movq	_ZN38_$LT$core..option..Option$LT$T$GT$$GT$6unwrap14_MSG_FILE_LINE17h2393103a4199f82dE@GOTPCREL(%rip), %rdi
	callq	_ZN4core9panicking5panic17h1a2d1a6b50eaa468E@PLT
.Lfunc_end0:
	.size	_ZN3lib16hamming_distance17hda0d3eda989316e2E, .Lfunc_end0-_ZN3lib16hamming_distance17hda0d3eda989316e2E
	.cfi_endproc

	.type	str8372,@object
	.section	.rodata.str8372,"a",@progbits
	.p2align	4
str8372:
	.ascii	"sequences must have the same length"
	.size	str8372, 35


	.section	".note.GNU-stack","",@progbits
