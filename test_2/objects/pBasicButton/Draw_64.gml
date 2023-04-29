if(spriteToDraw != -1){
	draw_self();
}

if(useHighLightHover){
	if(position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
		draw_sprite(useHighLightHoverImage,HighLightHoverSubImage, x, y);
		draw_self();
	}
}