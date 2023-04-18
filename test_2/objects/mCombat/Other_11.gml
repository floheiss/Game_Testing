if(layer_get_visible(baseUI)){
	layer_set_visible(baseUI,false);
	instance_deactivate_layer(baseUI);
}else {
	layer_set_visible(baseUI,true);
	instance_activate_layer(baseUI);
}