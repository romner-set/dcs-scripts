#include auto_oculus_touch.ahk
; Air Mouse Example
; This uses pitch/yaw to simulate a mouse like an LG TV remote.

speed:=20

InitOculus()

Poll()
pitch:=GetPitch(1)
yaw:=GetYaw(1)

Loop {
    Poll()
	; Get right controller angles.
	y:=GetYaw(1)
	p:=GetPitch(1)
	; Hold right hand trigger to activate motion.
	if GetAxis(AxisHandTriggerRight) > 0.5
		SendRawMouseMove((y-yaw)*speed, (p-pitch)*-speed, 0)
	yaw := yaw*0.1 + y*0.9
	pitch := pitch*0.1 + p*0.9
	
	; Use the right index trigger as the left mouse button
	if Reached(AxisIndexTriggerRight, 0.8)==1
		SendRawMouseButtonDown(0)
	if Reached(AxisIndexTriggerRight, 0.8)==-1
		SendRawMouseButtonUp(0)

	; Use the A button as the right mouse button
	if IsPressed(ovrA)
		SendRawMouseButtonDown(1)
	if IsReleased(ovrA)
		SendRawMouseButtonUp(1)
		
    Sleep, 10
}

