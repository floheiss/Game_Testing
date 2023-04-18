if(layer_get_visible(menusUI)){
	layer_set_visible(menusUI,false);
	instance_deactivate_layer(menusUI);
}else {
	layer_set_visible(menusUI,true);
	instance_activate_layer(menusUI);
}