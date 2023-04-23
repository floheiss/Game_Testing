#macro MOUSEGUI_X device_mouse_x_to_gui(0)
#macro MOUSEGUI_Y device_mouse_y_to_gui(0)

#macro Camera_Width camera_get_view_width(view_camera[0])
#macro Camera_Height camera_get_view_height(view_camera[0])

#macro Display_ScaleX display_get_gui_width()/Camera_Width
#macro Display_ScaleY display_get_gui_height()/Camera_Height

global.map = false; //default false
global.contract = false; //default false




global.maxInventorySize = 12;
global.inventory = []; //default []
global.maxPlayGroupSize = 2; //default 2
global.gold = 1000; //gold of the player 

global.playerGroup = array_create(global.maxPlayGroupSize, -1); //default -1 for all slots
global.enemies = []; //default []

global.ItemGen = instance_create_depth(0,0,0,mItem); //fk items 

allowInput = true;

//retuns the instance of the BM in the Party
function getPlayerInfo(){
	for(i = 0; i < array_length(global.playerGroup); i ++){
		unit = global.playerGroup[i];
		if(unit.class == classList.bloodMage){
			return global.playerGroup[i];
		}
	}
}

//is used to transition rooms 
//as some things have to be done befor and after
function transitionRoom(_roomToGoTO){
	room_goto(_roomToGoTO);
	for(i = 0; i < array_length(global.inventory); i ++){
		if(global.inventory[i] != -1){
			global.inventory[i].updateCanBeUsed();
		}
	}
	
}

//returns a open position in the player Group
// returns -1 if there are none 
function findOpenSlotInPlayGroup(){
	position = -1;

	for(i = 0; i < array_length(global.playerGroup); i ++){
		if(global.playerGroup[i] == -1){
			position = i;
			break;
		}
	}
	if(position == -1){
		show_debug_message("there are no open slots");
	}

	return position;
}