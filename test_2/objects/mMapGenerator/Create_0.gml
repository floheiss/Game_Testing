//wip ??? --> 70% finished have to make boss note / have to add lines 
//	/ have to add active and not active Buttons 
//generates a Map based difficulty
//difficulty can be change with params --> exmaple there can be more elite
//i can be longer, it can have more notes in columns,
//have to test !!!!!!!!!!!!!!!
//LOTS OF TESTING
function generateMap(_length, _maxNumberInColumn, _probabilityQuestion, _probabilityQuestionGood, _probabilityElite){
	randomize();

	lengthRows = _length;
	
	objects = findMapObjects();
	currentObject = 0;
	numberObjectInCurrentColumn = 0;
	
	notesInColumns = [];
	objectAtNotes = [];
	
	minNumberInColumn = 2;
	maxNumberInColumn = min(_maxNumberInColumn, 5);
	
	probabilityQuestion = _probabilityQuestion;
	probabilityQuestionGood  = _probabilityQuestionGood;
	probabilityElite = _probabilityElite;
	
	for(currentRow = 0; currentRow < lengthRows; currentRow ++){
		
		numberObjectInCurrentColumn = 0;
		
		if(currentRow == 0){
			numberInCulumn =  4;
			notesInColumns[currentRow] = numberInCulumn;
				
			//finds position XY and splits them for X and Y
			xyCords = findPositionMap(currentRow, notesInColumns[currentRow]);
			positonsXCords = [];
			positonsYCords = [];
			for(var j = 0; j < numberInCulumn; j ++){
				positonsXCords[j] = xyCords[0][j];
				positonsYCords[j] = xyCords[1][j];
			}
					
			for(i = 0; i < numberInCulumn; i ++){
				spawer = objects[|currentObject];
				//might need to be saved for later not sure
				creation = instance_create_depth(positonsXCords[i], positonsYCords[i], 0 , oMapEnemy);

				objectAtNotes[currentObject] = new mapNoteCreate(positonsXCords[i], positonsYCords[i], [],noteTypes.enemy, currentObject);
				currentObject ++;
			}
		}else{
			
			numberInCulumn = notesInColumns[currentRow - 1] + ceil(random_range(-2, 1));
			numberInColumn = max(minNumberInColumn, numberInCulumn);
			numberInColumn = min(maxNumberInColumn, numberInColumn);
			notesInColumns[currentRow] = numberInColumn;
				
				
			xyCords = findPositionMap(currentRow, numberInColumn);
			positonsXCords = [];
			positonsYCords = [];
			for(j = 0; j < numberInColumn; j ++){
				positonsXCords[j] = xyCords[0][j];
				positonsYCords[j] = xyCords[1][j];
			}
			
			
			for(i = 0; i < numberInColumn; i ++){
				spawer = objects[|currentObject];
				
				//have to add preNotes  i dont know the math behind it yet 
				preNotes = [];
				
				//might rework later to changed spawn numbers : ) 
				encounter = random(1);
				if(encounter < probabilityElite){
					// here is a elite 
					spawer = objects[|currentObject];
					objectAtNotes[currentObject] = new  mapNoteCreate(positonsXCords[i], positonsYCords[i], preNotes,noteTypes.elite, currentObject);
					numberObjectInCurrentColumn ++;
					currentObject ++;
					
				}else if(encounter < probabilityQuestion){
					// here is a question 
					spawer = objects[|currentObject];
					if(random(1) < probabilityQuestionGood){
						objectAtNotes[currentObject] = new mapNoteCreate(positonsXCords[i], positonsYCords[i], preNotes,noteTypes.question, currentObject, eventKinds.good);
						numberObjectInCurrentColumn ++;
						currentObject ++;
					}else{
						
						objectAtNotes[currentObject] = new mapNoteCreate(positonsXCords[i], positonsYCords[i],preNotes, noteTypes.question, currentObject, eventKinds.bad);
						numberObjectInCurrentColumn ++;
						currentObject ++;
					}
		
		
				}else{
					//here is a enemy 
					spawer = objects[|currentObject];
					objectAtNotes[currentObject] = new mapNoteCreate(positonsXCords[i], positonsYCords[i],preNotes, noteTypes.enemy,currentObject);
					numberObjectInCurrentColumn ++;
					currentObject ++;
					
				}
			}
		
		}
			
	}
	
	map = new mapCreate(lengthRows, notesInColumns, objectAtNotes);
	return map;
}

function displayMap(map){
	objects = findMapObjects();
	
	for(currentObject = 0; currentObject < array_length(map.objectAtNotes); currentObject ++){
		currentNote = map.objectAtNotes[currentObject];
		switch(currentNote.typeOfNote){
			case noteTypes.enemy:
				creation = instance_create_depth(currentNote.xCord,currentNote.yCord, currentNote.subImage, oMapEnemy);
				addVariablsToCreation(creation,currentObject, currentNote);
				
			break;
			case noteTypes.elite:
				creation = instance_create_depth(currentNote.xCord, currentNote.yCord, currentNote.subImage, oMapEnemyElite);
				addVariablsToCreation(creation,currentObject, currentNote);
			break;
			case noteTypes.question:
				creation = instance_create_depth(currentNote.xCord, currentNote.yCord,currentNote.subImage, oMapQuestion);
				addVariablsToCreation(creation,currentObject, currentNote);
				creation.eventKind = currentNote.specific;
			break;
		}
	}
}

//finds cSpawner in the Map are used to generate notes 
function findMapObjects(){
	list = ds_list_create();
	for(var i = 0; i < instance_number(cSpawner);i ++){
		instance = instance_find(cSpawner, i);
		ds_list_add(list, instance);
	}
	return list;
}

//find a position for the given row and  number in column
//x and y are first fixed but will be moved by a small amout 
function findPositionMap(row, numberInColumn){
	randomize();
	xRow = 192 * row + 64; 	
	yDIff = 592 / numberInColumn;
	
	xCords = [];
	yCords = [];
	for(i = 0; i < numberInColumn; i ++) {
		xCords[i] = xRow + ceil(random_range(- 10, 10));
		yCords[i] = yDIff * i + 64 + ceil(random_range(- 50, 50));
		
	}
	xyCords = [xCords, yCords];
	return xyCords;

}


//a strct that is a save for the map --> length, number of notes, and objects of the notes 
//is used to generate the same map again after battle or other
//generate Map
function mapCreate(_length, _notesInColumns, _objectAtNotes) constructor{
	length = _length;
	notesInCloumns = [];
	for(i = 0; i < array_length(_notesInColumns); i++){
		notesInCloumns[i] = _notesInColumns[i];
	}
	objectAtNotes = [];
	for(i = 0; i < array_length(_objectAtNotes); i++){
		objectAtNotes [i] = _objectAtNotes[i];
	}
	
}


//a struct that is used to save the map 
//it saves its x,y,type and 1 other variable(is the event good or bad for Questions)
function mapNoteCreate(_xCord, _yCord, _preNotes,_typeOfNote, _position,_specific = -1) constructor{
	xCord = _xCord;
	yCord = _yCord;
	typeOfNote = _typeOfNote;
	specific = _specific;
	positionInList = _position;
	preNotes = [];
	for(i = 0; i < array_length(_preNotes); i ++){
		preNotes[i] = _preNotes[i];
	}
	subImage = 0;
}


//adds all current Variabls to a MapObject 
//position, specific and preNotes
function addVariablsToCreation(creation,currentObject, currentNote){
	creation.positionInList = currentObject;
	for(i = 0; i < array_length(currentNote.preNotes); i ++){
		creation.preNotes[i] = currentNote.preNotes[i]
	}
}









