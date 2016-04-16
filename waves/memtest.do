onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /data_memory/address
add wave -noupdate -expand /data_memory/write_data
add wave -noupdate /data_memory/control_write
add wave -noupdate /data_memory/read_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 199
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
WaveRestoreZoom {0 ps} {930 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern constant -value 0000 -range 3 0 -starttime 0ps -endtime 1000ps sim:/data_memory/address 
WaveExpandAll -1
wave create -driver freeze -pattern constant -value 1001 -range 3 0 -starttime 0ps -endtime 1000ps sim:/data_memory/write_data 
wave create -driver freeze -pattern repeater -initialvalue 1 -period 300ps -sequence { 1 0  } -repeat forever -range 0 0 -starttime 0ps -endtime 1000ps sim:/data_memory/control_write 
wave create -driver freeze -pattern repeater -initialvalue 1 -period 300ps -sequence { 0  } -repeat forever -range 0 0 -starttime 0ps -endtime 1000ps sim:/data_memory/control_write 
wave create -driver freeze -pattern repeater -initialvalue 1 -period 300ps -sequence { 0  } -repeat never -range 0 0 -starttime 0ps -endtime 1000ps sim:/data_memory/control_write 
wave create -driver freeze -pattern constant -value 1 -range 0 0 -starttime 0ps -endtime 300ps sim:/data_memory/control_write 
wave create -driver freeze -pattern constant -value 1 -range 0 0 -starttime 0ps -endtime 1000ps sim:/data_memory/control_write 
WaveExpandAll -1
wave edit invert -start 304ps -end 1000ps Edit:/data_memory/control_write 
wave create -driver freeze -pattern constant -value 1001 -range 3 0 -starttime 0ps -endtime 1000ps sim:/data_memory/write_data 
WaveExpandAll -1
WaveCollapseAll -1
wave clipboard restore
