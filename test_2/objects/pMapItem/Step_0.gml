event_inherited();

//Debug Code
if(HoverFunction != noone && 
	position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id) &&
	btnState != buttonState.disabled){
	script_execute(HoverFunction);
	mMapDisplayManager.hoveredNote = self;
}
