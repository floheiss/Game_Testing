positionInList = 0;
preNotes = [];

function useMapNote(){
		
}

function updateMapList(){
	currentNote = global.map.objectAtNotes[positionInList];
	currentNote.subImage = 1;
}

function displayMapEvent(){
	with(mMapDisplayManager){
		event_user(0);
	}
	with(oGame){
		event_user(0);
		event_user(0);
	}
}