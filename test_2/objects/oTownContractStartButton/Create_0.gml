event_inherited();

changeSprite(x,y,sprite_index,true);

var con = function(){
	if(global.contract != false && oTown.currentMenu == -1){
		return true;
	}else{
		return false;
	}
}
setConditionForDrawing(con);

MainFunction = function(){
	if(oTown.currentMenu == -1){
		oGame.transitionRoom(rDungeonMap);
	}
}