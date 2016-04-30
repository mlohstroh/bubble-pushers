.text

beg: addi $s1, $zero, 10
addi $s0, $s0, 10
beq $s0, $s1, beg
j end
add $s0, $zero, $zero
end: