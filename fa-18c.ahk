SetWorkingDir, auto_oculus_touch ;_v0.1.7
#include auto_oculus_touch\auto_oculus_touch.ahk

; Start the Oculus sdk.
InitOculus()
InitvJoy(1)

Loop {
    Poll()
	
	; UNIVERSAL
	if IsPressed(ovrEnter)
		Send {F24 down}																		;discord PTT
	if IsReleased(ovrEnter)
		Send {F24 up}
	
	rightIndexTrigger := GetTrigger(RightHand, IndexTrigger)
	leftIndexTrigger := GetTrigger(LeftHand, IndexTrigger)
	leftX := GetThumbStick(LeftHand, XAxis)
	leftY := GetThumbstick(LeftHand, YAxis)
	rightX := GetThumbStick(RightHand, XAxis)
	rightY := GetThumbStick(RightHand, YAxis)

	; no mod key
	if not IsDown(ovrA) {
		if IsPressed(ovrB)  
			Send {, down}																	;cage/uncage
		else if IsReleased(ovrB)
			Send {, up}
			Send {Space up}

		if Reached(AxisYRight, 0.75) = 1
			Send {a down} 																	;extend airbrake
		else if Reached(AxisYRight, 0.75) = -1
			Send {a up}

		if IsPressed(ovrRThumb)
			Send {s down}																	;NWS
		else if IsReleased(ovrRThumb)
			Send {s up}

		if (IsTouchDown(ovrTouch_RThumb)) {													;wheel brake
			if Reached(AxisIndexTriggerRight, 0.5) = 1
				Send {w down}
			else if Reached(AxisIndexTriggerRight, 0.5) = -1
				Send {w up}
			; SetvJoyAxis(HID_USAGE_Z, rightIndexTrigger)
		} else {
				; SetvJoyAxis(HID_USAGE_Z, 0.0)
			if IsDown(ovrB) or (not (IsTouchDown(ovrTouch_A) or IsTouchDown(ovrTouch_B))) {
				if Reached(AxisIndexTriggerRight, 0.5) = 1									;AA weapon fire
					Send {Space down}
				else if Reached(AxisIndexTriggerRight, 0.5) = -1
					Send {Space up}
			}
			if not (IsTouchDown(ovrTouch_X) or IsTouchDown(ovrTouch_Y)) {					;AG weapons release
				if Reached(AxisIndexTriggerLeft, 0.5) = 1
					Send {c down}
				else if Reached(AxisIndexTriggerLeft, 0.5) = -1
					Send {c up}
			}
		}

		SetvJoyAxis(HID_USAGE_RX, rightX)													;rudder

		SetvJoyAxis(HID_USAGE_X, leftX)														;TDC slew
		SetvJoyAxis(HID_USAGE_Y, leftY)

		if IsPressed(ovrLThumb)
			Send {Enter down}																;TDC depress
		else if IsReleased(ovrLThumb)
			Send {Enter up}

		; a, touching b
	} else if IsTouchDown(ovrTouch_B) {
		if IsPressed(ovrB)
			Send {b down}																	;retract airbrake
		else if IsReleased(ovrB)
			Send {b up}

		if Reached(AxisIndexTriggerLeft, 0.3) = 1
			Send {. down}																	;comms menu
		else if Reached(AxisIndexTriggerLeft, 0.3) = -1
			Send {. up}

		if Reached(AxisIndexTriggerRight, 0.3) = 1
			Send {u down}																	;catapult hook
		else if Reached(AxisIndexTriggerRight, 0.3) = -1
			Send {u up}

		if IsPressed(ovrLThumb)																;sensor control depress
			Send {q down}
		else if IsReleased(ovrLThumb)
			Send {q up}

		if Reached(AxisXLeft, 0.5) = 1														;sensor control right
			Send {Numpad9 down}
		else if Reached(AxisXLeft, 0.5) = -1
			Send {Numpad9 up}
		
		if Reached(AxisXLeft, -0.5) = -1													;sensor control left
			Send {Numpad8 down}
		else if Reached(AxisXLeft, -0.5) = 1
			Send {Numpad8 up}
		
		if Reached(AxisYLeft, 0.5) = 1														;sensor control fwd
			Send {NumpadSub down}
		else if Reached(AxisYLeft, 0.5) = -1
			Send {NumpadSub up}

		if Reached(AxisYLeft, -0.5) = -1													;sensor control aft
			Send {NumpadAdd down}
		else if Reached(AxisYLeft, -0.5) = 1
			Send {NumpadAdd up}

	; a, not touching b
	} else {

		if Reached(AxisIndexTriggerRight, 0.3) = 1
			Send {e down}																	;fwd CM/chaff
		else if Reached(AxisIndexTriggerRight, 0.3) = -1
			Send {e up}
		if Reached(AxisIndexTriggerLeft, 0.3) = 1
			Send {f down}																	;aft CM/flares
		else if Reached(AxisIndexTriggerLeft, 0.3) = -1
			Send {f up}

		if not IsDown(ovrLThumb) {
			if Reached(AxisYLeft, 0.5) = 1													;select cannon
				Send {Numpad1 down}
			else if Reached(AxisYLeft, 0.5) = -1
				Send {Numpad1 up}
			
			if Reached(AxisXLeft, 0.5) = 1													;select AMRAAM
				Send {Numpad0 down}
			else if Reached(AxisXLeft, 0.5) = -1
				Send {Numpad0 up}
			
			if Reached(AxisXLeft, -0.5) = -1												;select sidewinder
				Send {Numpad2 down}
			else if Reached(AxisXLeft, -0.5) = 1
				Send {Numpad2 up}

			if Reached(AxisYLeft, -0.5) = -1												;select sparrow
				Send {Numpad3 down}
			else if Reached(AxisYLeft, -0.5) = 1
				Send {Numpad3 up}

		; a + r joystick button, touching b
		} else {
			if Reached(AxisXLeft, 0.5) = 1													;trim right
				Send {Numpad7}
			
			if Reached(AxisXLeft, -0.5) = -1												;trim left
				Send {Numpad4}
			
			if Reached(AxisYLeft, 0.5) = 1													;trim push
				Send {Numpad6}

			if Reached(AxisYLeft, -0.5) = -1												;trim pull
				Send {Numpad5}
		}
	}

	Sleep, 10
}