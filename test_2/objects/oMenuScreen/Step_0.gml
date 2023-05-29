if(currentMenu == menus.partyInfo){
	var unit = currentDisplayedSupport;
	if(layer_sequence_get_headpos(memberSequence) > unit.idleEnd){
		layer_sequence_headpos(memberSequence, unit.idleStart);
	}
}