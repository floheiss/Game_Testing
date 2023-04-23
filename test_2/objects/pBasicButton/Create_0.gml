image_speed = 0;
btnState = buttonState.active;

spriteToDraw = -1;

contract = false;
itemDisplayed = false;
position = 0;

subImageBtnIndicUse = true;

function changeSprite(_xCord, _yCord, _spriteToChangeTo){
	x = _xCord;
	y = _yCord;
	spriteToDraw = _spriteToChangeTo;
	sprite_index = _spriteToChangeTo;
}