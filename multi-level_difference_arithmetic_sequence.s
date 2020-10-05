.data
	initial:	.word 	0	# Initial term value (a0)
	levels:		.word	3	# Levels of difference
	target:		.word 	10	# Print until this index
	diff_list:	.word	1	# Sequence difference list. Starts from level 0.
				.word	2	
				.word	3	
	str1:		.asciz	"The "	# NULL character seperated due to terminal printing "\0"
				.byte	0x00
	str2:		.asciz 	"-th term of the sequence is "
				.byte	0x00
	str_end:	.asciz	".\n"
				.byte	0x00

.text

# Register usage:
# 	t0: index - t1: result - t2: target index
#
main:
	li		t0, 0
	la		t1, initial
	lw		t1, 0(t1)
	la		t2, target
	lw		t2, 0(t2)
	jal		ra, print		# Print the initial term (a0)

main_loop:
	beq		t2, t0, exit	# End execution if target reached
	la		t3, diff_list
	lw		t3, 0(t3)
	add		t1, t1, t3		# Get next value in sequence
	addi	t0, t0, 1		# Update index
	jal		ra, print
	
	la		t3, levels		# Load total levels (for branching)
	lw		t3, 0(t3)		
	addi	t3, t3, -1
	li		t4, 0			# Offset for adjusting
	la		t5, diff_list	# Preload diff_list address
	add		s0, t5, x0
	lw		s0, 0(s0)		# Load diff_0

update_difference:	# diff_a == s0, diff_a+1 == ts1
	li		s1, 4			# Load diff_a+1
	addi	t6, t4, 1
	mul		s1, t6, s1
	add		s1, s1, t5
	lw		s1, 0(s1)
	add		s0, s0, s1		# Perform adjustment
	li		t6, 4			# Save adjusted differents
	mul		t6, t6, t4
	add		t6, t6, t5
	sw		s0, 0(t6)
	addi	t4, t4, 1
	mv		s0, s1

	addi	t3, t3, -1
	bne		t3, x0, update_difference
	j 		main_loop

print:
	li		a7, 4
	la		a0, str1
	ecall
	li		a7, 1		# Current index
	mv		a0, t0		#
	ecall				#
	li		a7, 4
	la		a0, str2
	ecall
	li		a7, 1		# Result goes here
	mv		a0, t1		#
	ecall				#
	li		a7, 4
	la		a0, str_end
	ecall
	ret	

exit:
	li		a7, 10
	ecall