# Declare constants used for creating a multiboot header
.set ALIGN,	1<<0		# align loaded modules on page boundaries
.set MEMINFO,	1<<1		# provide memory map
.set FLAGS,	ALIGN | MEMINFO # this is the multiboot 'flag' field
.set MAGIC,	0x1BADB002	# 'magig number' let's bootloader find the header
.set CHECKSUM,	-(MAGIC + FLAGS) # checksum of above, to prove we are multiboot

# Header
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

# Provide our own stack
.section .bootstrap_stack, "aw", @nobits
.skip 16384 # 16 KiB
stack_top:

# Bootloader will jump to this position once the kernel has been loaded
.section .text
.global _start
.type _start, @function
_start:
	# Welcome to kernel mode!
	# Set up processor
	movl $stack_top, %esp

	# We are now ready to execute C code
	call kernel_main	# from kernel.c

	# If function returns, put computer into an infinite loop
	cli
	hlt
.Lhang:
	jmp .Lhang

# Set size of _start symbol to the current location '.' minus its start.
# Useful for debugging or if you implement call tracing
.size _start, . - _start
