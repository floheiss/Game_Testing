event_inherited();

eventKind =  eventKinds.good;
//is used when the note is clicked on the Map
function useMapNote(){
	//generate the event 
	//set the menu in the mDisplayManager
		
	with(mMapDisplayManager){
		event_user(0);
	}
	with(oGame){
		event_user(0);
		event_user(0);
	}
}
