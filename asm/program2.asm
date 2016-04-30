.text

addi $t0, $zero, 30, 
addi $s0, $s0, 20
sub $t1, $t0, $s0 # subtract 30 by 20
j end
sub $s0, $zero, $zero
end:
addi $t1, $t1, 100 # result should be 110