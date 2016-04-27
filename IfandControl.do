view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/testingIFandControl/clk 
wave create -driver freeze -pattern repeater -initialvalue 1 -period 75ps -sequence { 1 0  } -repeat never -starttime 0ps -endtime 120ps sim:/testingIFandControl/rst 
WaveCollapseAll -1
wave clipboard restore
