; Configuration file for Duet WiFi (firmware version 1.21)
; executed by the firmware on start-up
;
; generated by RepRapFirmware Configuration Tool v2 on Tue Dec 25 2018 20:01:03 GMT-0600 (Central Standard Time)
; Modified 12 August 2019 - osh

; Debugging
M111 S0												; Debug (S0 is off; S1 is on)
M929 P"eventlog.txt" S1								; start logging to file eventlog.txt
M915 X Y S10 F0 R1                                  ; log motor stalls (added 5/4/2019)

; General preferences
G21													; Work in millimetres
G90                                                 ; Send absolute coordinates...
M83                                                 ; ...but relative extruder moves

M555 P2												; Set output to look like Marlin
M669 K1												; Select CoreXY kinematics (RRF 2.03 and later)

; Network
M550 P"RailCore"                                    ; Set machine name
M552 P0.0.0.0 S1                                    ; Enable network and acquire dynamic address via DHCP
M586 P0 S1                                          ; Enable HTTP
M586 P1 S0                                          ; Disable FTP
M586 P2 S0                                          ; Disable Telnet

; Drives
M584 X0 Y1 Z5:6:7 E3:4:8:9 							; Map Z to drivers 5, 6, 7. Define unused drivers 3,4,8 and 9 as extruders
M569 P0 S0                          				; Drive 0 goes backwards  	X/Y stepper (front?)
M569 P1 S1                          				; Drive 1 goes forwards		X/Y Stepper (rear?)
M569 P2 S1                         					; Drive 2 goes forwards		Unused
M569 P3 S1                          				; Drive 3 goes forwards		Extruder (forward for LDO motor)
M569 P4 S1                          				; Drive 4 goes forwards		Extruder (unused)
M569 P5 S0											; Drive 5 goes backwards	Front Left Z
M569 P6 S0											; Drive 6 goes backwards	Rear Left Z
M569 P7 S0											; Drive 7 goes backwards	Right Z

; Leadscrew locations
M671 X-10:-10:340  Y16:266:139 S7.5  				; Front left (-10,16), Rear Left (-10,266), Right (340,139)    1/9/2019 - osh - S7.5 is the max correction - measure your own offsets, to the bolt for the yoke of each leadscrew

; Axis and motor configurations
M350 X16 Y16 Z16 E16 I1                             ; Configure 16x microstepping with interpolation
M906 X1280 Y1280 Z1220 E860 I50                     ; Set motor currents (mA) and motor idle factor in per cent (docs say rounds to 100, but this is where I'd like them to be)
M92 X200.0 Y200.0 Z1600.0 E836.0                    ; Set steps per mm (25 June 2019)
M566 X600 Y600 Z200 E3600             			    ; Set maximum instantaneous (jerk) speed changes (mm/min)
M201 X1750 Y1750 Z250 E1500                         ; Set accelerations (mm/s^2)
M203 X24000 Y24000 Z900 E3600       			    ; Set maximum speeds (mm/min)
M84 S60												; Set motor idle timeout
M579 X1.0028 Y1.0021								; Scale X and Y axis

; Axis Limits
M208 X290 Y290 Z335                 				; set axis maxima and high homing switch positions (adjust to suit your machine) - 1/27/2019 - osh
M208 X0 Y0 Z0 S1                    				; set axis minima and low homing switch positions (adjust to make X=0 and Y=0 the edges of the bed);

; Endstops
M574 X1 Y1 S1                                    	; Set active high endstops

; Z-Probe - BLTouch "Smart v3"
M307 H7 A-1 C-1 D-1    								; BL-touch : remaps some channels to make the PWM port on the Duex5 work for a Z-probe
M574 Z0 S2											; Set endstops controlled by probe
M208 S1 Z-0.2										; set minimum Z


;M557 X10:282 Y45:255 P4:4		    				; Set Default Mesh - NOTE: take probe offset into account - full bed
M557 X45:282 Y46:254 P2:2							; Set Default Mesh - NOTE: take probe offset into account - corners only
;                                     				; E.G. If probe offset is 42 on Y, then Y50:290 will take the hotend to Y08 to Y248)
M558 P9 H5 F150 T3000 A3 S0.02  					; BLTouch probe config line
G31 X2 Y42 Z1.98 H5 P25 							; Customize your offsets appropriately. (Nozzle X)
;													; Tip: A larger trigger height in G31 moves you CLOSER to the bed

; Heaters
M305 P0 S"Bed" T100000 B3950 R4700                  ; Set thermistor + ADC parameters for heater 0 (Bed)
M143 H0 S120                                      	; Set temperature limit for heater 0 to 120C
M305 P1 S"HotEnd" T100000 B4725 R4700 C7.06e-8      ; Set thermistor + ADC parameters for heater 1 (Hot-end) - testing 6 May 2019
M143 H1 S288                                      	; Set temperature limit for heater 1 to 280C
M305 P107 S"Keenovo" X7 T100000 B3950 R4700			; Secondary bed thermistor
M140 S-273 R-273                          			; Standby and initial Temp for bed as "off" (-273 = "off")

M307 H1 A423.0 C203.8 D4.5 S1.00 V24.4 B0			; Heater 1 - Hot-end - PID tuned 6/30/2019
M307 H0 A295.6 C911.7 D9.3 S1.00 V24.4 B0			; Heater 0 - MIC 6 Bed - PID tuned 6/30/2019

; Fans
M106 P0 S0 I0 F500 H-1               	          	; Set fan 0 value, PWM signal inversion and frequency. Thermostatic control is turned off
M106 P1 S1 I0 F500 H1 T40                         	; Set fan 1 value, PWM signal inversion and frequency. Thermostatic control is turned on

; Tools
M563 P0 D0 H1                                     	; Define tool 0
G10 P0 X0 Y0 Z0                                   	; Set tool 0 axis offsets
G10 P0 S-273 R-273									; Set tool 0 operating and standby temperatures(-273 = "off")

; Automatic power saving
M911 S10 R11 P"M913 X0 Y0 G91 M83 G1 Z3 E-5 F1000" ; Set voltage thresholds and actions to run on power loss

; Custom settings are not configured

; Miscellaneous
;M501                                               ; Load saved parameters from non-volatile memory - not used by osh
T0												   	; Select first hot-end
M98 P/macros/LED_Ready_Low							; Turn on LED lights