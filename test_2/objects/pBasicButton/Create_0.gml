image_speed = 0;
btnState = buttonState.active;
spriteToDraw = -1;

function changeSprite(_xCord, _yCord, _spriteToChangeTo, _useSubImage = false, _imageIndex = 0){
	x = _xCord;
	y = _yCord;
	useSubImage = _useSubImage
	spriteToDraw = _spriteToChangeTo;
	sprite_index = _spriteToChangeTo;
	image_index = _imageIndex;
}

