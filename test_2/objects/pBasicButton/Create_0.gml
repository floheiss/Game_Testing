image_speed = 0;
btnState = buttonState.active;
spriteToDraw = -1;

useHighLightHover = false;
useHighLightHoverImage = -1;
HighLightHoverSubImage = 0;

displayedText = "";
displayedTextxCord = 0;
displayedTextyCord = 0;

drawInGui = true; //is used to draw Buttons on the gui is defualt 
drawInMap = false; //is used to draw Buttons on a map

condition = -1; //saves a condition to check for 
//when the condition returns true the button is not locked
conditionParamArray = []; //saves any number of params for the condition
locked = false; //false is default and means the button can beused

//is used to set the button 
//sets the x/y position of a button
//sets the sprite and if subimages are used
function changeSprite(_xCord, _yCord, _spriteToChangeTo, _useSubImage = false, _imageIndex = 0){
	x = _xCord;
	y = _yCord;
	spriteToDraw = _spriteToChangeTo;
	sprite_index = _spriteToChangeTo;
	image_index = _imageIndex;
	useSubImage = _useSubImage;
}


//is used for highlighting when hovered
//is given the image (can use a subimage of the normal image
//Subimage can also not be set
function setUseHighlightHoverImage(_HighLightHoverImage, _HighLightHoverSubImage = 0){
	useHighLightHover = true;
	useHighLightHoverImage = _HighLightHoverImage; 
	HighLightHoverSubImage = _HighLightHoverSubImage;
}

//is used to displayText On the Button
//can be given an alignment 
//"center" | "right" | "left"
function setDisplayedText(_displayedText, _displayedTextxCord = 0, _displayedTextyCord = 0){
	displayedText = _displayedText;
	displayedTextxCord = _displayedTextxCord;
	displayedTextyCord = _displayedTextyCord;
}

//is used to update the locked condition of the button 
function setConditionForLocking(_condition, _conditionParamArray = []){
	condition = _condition;
	if(!is_array(_conditionParamArray)){
		conditionParamArray[0] = _conditionParamArray;
	}else{
		for(var i = 0; i < array_length(_conditionParamArray); i ++){
			conditionParamArray[i] = _conditionParamArray[i];
		}
	}
	if(condition != -1){
		if(is_bool(condition)){
			locked = !condition;
		}else if(is_method(condition)){
			locked = method_call(condition,conditionParamArray);
		}else{
			locked = script_execute(condition, conditionParamArray);
		}
	}
	if(locked == true){
		btnState = buttonState.disabled;
	}
}




function resetButton(){
	spriteToDraw = -1;
	useHighLightHover = false;
	useHighLightHoverImage = -1;
	HighLightHoverSubImage = 0;
	
	displayedText = "";
	displayedTextxCord = 0;
	displayedTextyCord = 0;
	
	locked = false;
	condition = -1;
	conditionParamArray = [];
}
