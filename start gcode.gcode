; Ender 3 START OF CUSTOM START GCODE

; TODO: figure out how to make it save its progress mid print so that I can pause and resume

; this code makes it so that bed and T0 heat simultaneously, and it heats at home position rather than wherever I happened to leave it
M140 S45    ; start warming bed to 45
M104 S{material_print_temperature_layer_0} T0 ; start heating T0 to what is set in Cura

; put all settings here
G21         ; mm units*
; M203 E50 X500 Y500 Z5              ; max feedrates per mm
M204 P450                            ; acceleration
M205 J0.2                            ; junction deviation
M206 X3 Y-6 Z0                       ; home offsets
M900 K0.2                            ; k-factor
M92  X80.488 Y80.4 Z400.5 E415       ; calibrated steps/mm
M906 E450 X690 Y690 Z920             ; set stepper currents in mA
M301 P10.89 I0.46 D64.67             ; PID Hotend setting
M304 P88.39 I15.14 D344.15           ; PID Bed setting
M851 X-43 Y-10 Z-1.675               ; ABL Offset
; lower z (larger '-' value) = lower first layer printed height

; auto home
G92 E0                              ; Reset Extruder
G28                                 ; Home all axes
G1 Z10 F3000                        ; raise a bit for bed heating
G1 X0 Y0 F3000                      ; home X and Y
M190 S50                            ; wait for minimum bed temp before probe
M140 S{material_bed_temperature_layer_0} ; start heating the bed to what is set in Cura
G29                                 ; ABL with 3d Touch
M500	                            ; save mesh to EEPROM
; M501                              ; load and use EEPROM settings
;M420 S1                            ; use this to skip ABL

G1 Z10 F3000                        ; raise up a little after calibration
G1 X0 Y0 F5000                      ; move in to pounce position for preheat (off-bed)
M190 S{material_bed_temperature_layer_0}       ; Wait for bed temp
M104 S{material_print_temperature_layer_0}           ; Wait for nozzle temp

; prime the nozzle before print
G90 ; absolute positioning
G1 X5 Y4 Z0.2 F5000                   ; move in to pounce position for nozzle clean
G1 E20 Z4 F300                         ; only if last GCODE finished with an unload
G1 X5 Y6 Z6                         ; Move up and away from the blob
G1 Y10 F3500                        ; Line up with print line
G1 X5 Y20 Z0.28 F2000               ; Move to start position
G92 E0                              ; Reset extruder position
G1 X5 Y180.0 Z0.28 E15 F1500        ; Draw the first line
G1 X5.3 Y180.0 Z0.28 F2000          ; Move to side a little
G1 X5.3 Y24 Z0.28 E30 F1500         ; Draw the second line
G1 Z1.5 F2000                    ; Move Z Axis up little to prevent scratching of Heat Bed, retract 1mm
G1 X6.5 Z0.1 F1000               ; Move over to prevent blob squish
G1 Z1 F1000                ; raise up a bit
G92 E0                              ; Reset Extruder

; END OF CUSTOM START GCODE