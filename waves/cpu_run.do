onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu/clk
add wave -noupdate /cpu/rst
add wave -noupdate /cpu/instruction
add wave -noupdate /cpu/ctrl/funct
add wave -noupdate /cpu/ctrl/op
add wave -noupdate /cpu/ctrl/mem_to_reg
add wave -noupdate /cpu/ctrl/mem_write
add wave -noupdate /cpu/ctrl/branch
add wave -noupdate /cpu/ctrl/alu_src
add wave -noupdate /cpu/ctrl/reg_dst
add wave -noupdate /cpu/ctrl/reg_write
add wave -noupdate /cpu/ctrl/jump
add wave -noupdate /cpu/ctrl/alu_ctrl
add wave -noupdate /cpu/decode/instr
add wave -noupdate /cpu/decode/pc
add wave -noupdate /cpu/decode/writeData
add wave -noupdate /cpu/decode/writeRegister
add wave -noupdate /cpu/decode/regWrite
add wave -noupdate /cpu/decode/opcode
add wave -noupdate /cpu/decode/funct
add wave -noupdate /cpu/decode/regOut1
add wave -noupdate /cpu/decode/regOut2
add wave -noupdate /cpu/decode/regRt
add wave -noupdate /cpu/decode/regRd
add wave -noupdate /cpu/decode/jumpDest
add wave -noupdate /cpu/decode/immValue
add wave -noupdate /cpu/decode/branchDest
add wave -noupdate /cpu/decode/regRs
add wave -noupdate /cpu/decode/branchAddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {429 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 193
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {969 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 200ps -dutycycle 50 -starttime 0ps -endtime 3000ps sim:/cpu/clk 
wave create -driver freeze -pattern clock -initialvalue 0 -period 200ps -dutycycle 50 -starttime 0ps -endtime 3000ps sim:/cpu/clk 
wave create -driver freeze -pattern constant -value 0 -starttime 0ps -endtime 3000ps sim:/cpu/rst 
wave edit invert -start 0ps -end 124ps Edit:/cpu/rst 
WaveCollapseAll -1
wave clipboard restore
