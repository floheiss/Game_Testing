if(layer_get_visible(targetUI)){
	layer_set_visible(targetUI,false);
	instance_deactivate_layer(targetUI);
}else {
	layer_set_visible(targetUI,true);
	instance_activate_layer(targetUI);
}