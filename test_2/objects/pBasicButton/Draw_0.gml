if(drawInMap){
	if(spriteToDraw != -1){
		draw_self();
	
		if(btnState == buttonState.disabled){
			var lockOverLayXscale = sprite_get_width(spriteToDraw)/128;
			var lockOverLayYscale = sprite_get_height(spriteToDraw)/128;
			draw_sprite_ext(LockedOverlay, 0,
			x - sprite_get_xoffset(spriteToDraw), 
			y - sprite_get_yoffset(spriteToDraw),
			lockOverLayXscale,lockOverLayYscale,0,c_white,1); 
		}
	
	}

	#region Highlight on hover 

	if(useHighLightHover && btnState != buttonState.disabled){
		if(position_meeting(mouse_x,mouse_y, id)){
			draw_sprite(useHighLightHoverImage,HighLightHoverSubImage, x, y);
			draw_self();
		}
	}

	#endregion

	#region Text in displayedText 

	if(displayedText != ""){
		displayedText = autoLineBreaker(displayedText, sprite_get_width(sprite_index) - 20, 30);
		xCord = x;
		yCord = y;
		if(displayedTextxCord != 0){
			xCord = displayedTextxCord;
		}
		if(displayedTextyCord != 0){
			yCord = displayedTextyCord;
		}
		draw_text(xCord, yCord, displayedText);
	}

	#endregion

}