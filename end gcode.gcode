; START OF CUSTOM END GCODE

G91                 ; Relative positioning
G1 E-5 F2700        ; Retract a bit
G1 E-5 Z0.2 F2400   ; Retract and raise Z
G1 X5 Y5 F3000      ; Wipe out
G1 Z10 E-10 F1500        ; Raise Z more
G90                 ; Absolute positionning

G1 X0 Y215          ; Present print
M106 S0             ; Turn-off fan
M104 S0             ; Turn-off hotend
M140 S0             ; Turn-off bed

M84 X Y E           ;Disable all steppers but Z

; END OF CUSTOM END GCODE