if(mapDisplayed && array_length(objects) == 0){
	objects = findMapItem();
}

if(mapDisplayed){
	activeColumn = global.map.activeColumn; 
	for(var i = 0; i < array_length(objects); i ++){
		var currNote = objects[i];
		if(activeColumn == 0){
			show_debug_message("the zero zone");
			if(currNote.columnSelf == activeColumn){
				show_debug_message("some not was chanced");
				currNote.locked = false;
			}
		}else if(currNote.columnSelf == activeColumn){
			show_debug_message("the > zero zone");
			for(var k = 0; k < array_length(currNote.preNotes); k++){
				show_debug_message("the pathInMap: " + string(global.map.pathInMap));
				
				if(global.map.pathInMap[array_length(global.map.pathInMap) - 1].positionInList == currNote.preNotes[k].positionInList){
					show_debug_message("i would unlock a note");
					currNote.locked = false;
				}
			}
		}else{
			currNote.locked = true;
		}
	}

}
