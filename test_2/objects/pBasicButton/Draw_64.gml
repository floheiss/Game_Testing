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

#region Highlight on hover 

if(useHighLightHover){
	if(position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
		draw_sprite(useHighLightHoverImage,HighLightHoverSubImage, x, y);
		draw_self();
	}
}

#endregion

#region Text in displayedText 

if(displayedText != ""){
	//not sure about the values 
	displayedText = autoLineBreaker(displayedText, sprite_get_width(sprite_index) - 20, 30);
	padding = 10;
	marging = 5;
	draw_text(x - padding, y- marging, displayedText);
}

#endregion


