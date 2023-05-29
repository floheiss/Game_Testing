if(oTown.currentMenu == -1 && global.allowInput  && position_meeting(MOUSEGUI_X,MOUSEGUI_Y, id)){
	if(global.contract != false or array_length(contracts) < 6){
		generateContracts();
	}
	
	with(oTown){
		currentMenu = menus.guild;
		displayMenuInTown();
	}
	
}