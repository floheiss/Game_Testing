event_inherited();

changeSprite(x,y,sprite_index,true);

var con = function(){
	if(oTown.currentMenu != -1){
		return true;
	}else{
		return false;
	}
}
setConditionForDrawing(con);

MainFunction = function(){
	with(oTown){
		currentMenu = -1;
		displayMenuInTown();
	}
}