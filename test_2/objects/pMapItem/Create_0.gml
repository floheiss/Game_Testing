event_inherited();

positionInList = 0;
columnSelf = 0

preNotes = [];

drawInMap = true;
drawInGui = false;

function mapNoteFunction(){
		
}

function updateMapList(){
	mMapManager.changeActiveColumn(self);
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
	endEvent = _endEvent;
}

var con = function(){
	var result = false;
	if(array_length(preNotes) > 0){
		for(var i = 0; i < array_length(preNotes); i ++){
			var note = preNotes[i];
			if(note != -1){
				if(note.locked){
					result = true;
					break;
				}
			}
		}
	}
	return result; 
}

//setConditionForLocking(con);