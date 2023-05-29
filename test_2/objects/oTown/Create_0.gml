currentMenu = -1;
menusUI = layer_get_id("menusUI");


function displayMenuInTown(){
	
	with(oGame){
		event_user(0);
	}
	event_user(1);
	oMenuScreen.displayMenu();
	with(oGame){
		event_user(0);
	}
	
}