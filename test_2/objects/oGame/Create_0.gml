
#macro MOUSEGUI_X device_mouse_x_to_gui(0)
#macro MOUSEGUI_Y device_mouse_y_to_gui(0)

#macro Camera_Width camera_get_view_width(view_camera[0])
#macro Camera_Height camera_get_view_height(view_camera[0])

#macro Display_ScaleX display_get_gui_width()/Camera_Width
#macro Display_ScaleY display_get_gui_height()/Camera_Height

global.map = false; //default false
global.contract = false; //default false

global.playerGroup = []; //default []
global.enemies = []; //default []

global.maxInventorySize = 12;
global.inventory = []; //default []
global.maxPlayGroupSize = 2; //default 2
global.gold = 1000; //gold of the player 


global.ItemGen = instance_create_depth(0,0,0,mItem); //fk items 

allowInput = true;

function getPlayerInfo(){
	for(i = 0; i < array_length(global.playerGroup); i ++){
		unit = global.playerGroup[i];
		if(unit.class == classList.bloodMage){
			return global.playerGroup[i];
		}
	}
}

function transitionRoom(_roomToGoTO){
	room_goto(_roomToGoTO);
	for(i = 0; i < array_length(global.inventory); i ++){
		if(global.inventory[i] != -1){
			global.inventory[i].updateCanBeUsed();
		}
	}
	
}
