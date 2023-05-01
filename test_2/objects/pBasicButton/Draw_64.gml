if(spriteToDraw != -1){
	if(spriteToDraw == LockedOverlay){
		image_xscale = lockOverLayXscale;
		image_yscale = lockOverLayYscale;
	}else{
		image_xscale = 1;
		image_yscale = 1;
	}
	draw_self();
}

if(useHighLightHover){
	if(position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
		draw_sprite(useHighLightHoverImage,HighLightHoverSubImage, x, y);
		draw_self();
	}
}



