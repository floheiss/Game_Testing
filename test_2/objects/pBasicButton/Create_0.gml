image_speed = 0;
btnState = buttonState.active;
spriteToDraw = -1;

useHighLightHover = false;
useHighLightHoverImage = -1;
HighLightHoverSubImage = 0;

lockOverLayXscale = 1;
lockOverLayYscale = 1;
locked = false; 

displayedText = "";
displayedTextxCord = 0;
displayedTextyCord = 0;




//is used to set the button 
//sets the x/y position of a button
//sets the sprite and if subimages are used
function changeSprite(_xCord, _yCord, _spriteToChangeTo, _useSubImage = false, _imageIndex = 0){
	x = _xCord;
	y = _yCord;
	useSubImage = _useSubImage
	spriteToDraw = _spriteToChangeTo;
	sprite_index = _spriteToChangeTo;
	image_index = _imageIndex;
}


//is used for highlighting when hovered
//is given the image (can use a subimage of the normal image
//Subimage can also not be set
function setUseHighlightHoverImage(_HighLightHoverImage, _HighLightHoverSubImage = 0){
	useHighLightHover = true;
	useHighLightHoverImage = _HighLightHoverImage; 
	HighLightHoverSubImage = _HighLightHoverSubImage;
}

function useLockedOverlay(_xCord, _yCord,_NormalSpite){
	x = _xCord;
	y = _yCord;
	spriteToDraw = _NormalSpite;
	sprite_index = _NormalSpite;
	btnState = buttonState.disabled;
	lockOverLayXscale = sprite_get_width(_NormalSpite)/128;
	lockOverLayYscale = sprite_get_height(_NormalSpite)/128;
	
}


//is used to displayText On the Button
//can be given an alignment 
//"center" | "right" | "left"
function setDisplayedText(_displayedText, _displayedTextxCord = 0, _displayedTextyCord = 0){
	displayedText = _displayedText;
	displayedTextxCord = _displayedTextxCord;
	displayedTextyCord = _displayedTextyCord;
}


function resetButton(){
	spriteToDraw = -1;
	useHighLightHover = false;
	useHighLightHoverImage = -1;
	HighLightHoverSubImage = 0;
	lockOverLayXscale = 1;
	lockOverLayYscale = 1;

	displayedText = "";
	
}


