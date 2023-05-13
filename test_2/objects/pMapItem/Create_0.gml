event_inherited();

positionInList = 0;
preNotes = [];
active = true;

drawInMap = true;
drawInGui = false;

function mapNoteFunction(){
		
}

function updateMapList(){
	currentNote = global.map.objectAtNotes[positionInList];
	currentNote.subImage = 1;
	// currentNote.active = false;
}

function displayMapEvent(){
	with(mMapDisplayManager){
		event_user(0);
	}
	with(oGame){
		event_user(0);
		for(i = 0; i < 200; i ++){
			
		}
		event_user(0);
	}
}




