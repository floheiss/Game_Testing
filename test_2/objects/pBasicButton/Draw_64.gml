if(drawInGui && getsDraw){
	if(spriteToDraw != -1 or lockWithOutImageFlag != -1){
		if(spriteToDraw != -1){
			draw_self();
		}
		
		if(btnState == buttonState.disabled && !useSubImage){
			//maybe error
			var spriteUsed = (spriteToDraw != -1)? spriteToDraw : lockWithOutImageFlag;
			var lockOverLayXscale = sprite_get_width(spriteUsed)/128;
			var lockOverLayYscale = sprite_get_height(spriteUsed)/128;
			draw_sprite_ext(LockedOverlay, 0,
			x - sprite_get_xoffset(spriteToDraw), 
			y - sprite_get_yoffset(spriteToDraw),
			lockOverLayXscale,lockOverLayYscale, 0, c_white, 1); 
		}
	}

	#region Highlight on hover 

	if(useHighLightHover && btnState != buttonState.disabled){
		if(position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
			draw_sprite(useHighLightHoverImage,HighLightHoverSubImage, x, y);
			draw_self();
		}
	}

	#endregion

	#region Text in displayedText 

	if(displayedText != ""){
		displayedText = autoLineBreaker(displayedText, sprite_get_width(sprite_index) - 20, 30);
		var xCord = x;
		var yCord = y;
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

