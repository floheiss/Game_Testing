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

//is uses to display an Option in any given Map event OR campfire
function mapOption(_text, _onClick, _condition, _endEvent = false) constructor{
	textForDisplay = _text;
	onClick = _onClick
	condition = _condition;
	locked = false; 
	endEvent = _endEvent;
	
	function updateCondition(){
		
		if(is_bool(condition)){
			if(!condition){
				locked = true;
			}
		}else{
			if(!script_execute(condition)){
				locked = true;
			}
		}
	}
	
	updateCondition();	
}


