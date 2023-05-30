event_inherited();

changeSprite(x,y,sprite_index,true);

MainFunction = function(){
	with(mCombat){
		targeting = false;
		if(!layer_get_visible(baseUI)){
			event_user(1);
		}
		if(layer_get_visible(targetUI)){
			event_user(2);
		}
	}
}