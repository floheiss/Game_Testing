event_inherited();

function mapNoteFunction(){
	updateMapList();
	oDM.genrateEnemys(0);
	//this is for now 
	locked = true;
	oGame.transitionRoom(rBattleScreen);
}