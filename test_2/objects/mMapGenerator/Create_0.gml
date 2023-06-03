//wip ??? --> 70% finished have to make boss note / have to add lines 
//	/ have to add active and not active Buttons 
//generates a Map based on difficulty
//difficulty can be change with params --> exmaple there can be more elite
//i can be longer, it can have more notes in columns,
//have to test !!!!!!!!!!!!!!!
//LOTS OF TESTING
function generateMap(_length, _maxNumberInColumn, _probabilityQuestion, _probabilityQuestionGood, _probabilityElite){
	randomize();

	#region findPositionMap
	
	//find a position for the given row and  number in column
	//x and y are first fixed but will be moved by a small amout 
	var findPositionMap = function(row, numberInColumn){
		randomize();
		var xRow = 192 * row + 64; 	
		var yDIff = 592 / numberInColumn;
	
		var Cords = [];
		var yCords = [];
		for(i = 0; i < numberInColumn; i ++) {
			xCords[i] = xRow + ceil(random_range(- 15, 15));
			yCords[i] = yDIff * i + 64 + ceil(random_range(- 15, 15));
		
		}
		var xyCords = [xCords, yCords];
		return xyCords;

	}

	
	#endregion

	#region structs 
	
	//a struct that is used to save the map 
	//it saves its x,y,type and 1 other variable(is the event good or bad for Questions)
	var mapNote = function(_xCord, _yCord, _preNotes,_typeOfNote, _position,_specific = -1) constructor{
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

	//a strct that is a save for the map --> length, number of notes, and objects of the notes 
	//is used to generate the same map again after battle or other
	//generate Map
	var map = function(_length, _notesInColumns, _objectAtNotes) constructor{
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
	
	#endregion

	#region generateRandomEvent
	
	//retuns a random event for a question
	//is given 1|0|-1 for good|neutral|bad 
	var generateRandomEvent = function(_eventKind){
		var tierChances = [];
		var tier3 = [];
		var tier2 = [];
		var tier1 = [];
		switch(_eventKind){
			case 1:
				tierChances = [-1,10,30];
				tier3 = [events.fallenGood]; //have to make all :) 
				tier2 = [events.campfire, events.merchant];
				tier1 = [events.campfire, events.merchant]; //have to look what will happen here
		
			break;
			case -1:
				tierChances = [-1,10,20];
				tier3 = [events.infection]; //have to make all :) 
				tier2 = [events.ambush, events.poisionFood];
				tier1 = [events.ambush, events.poisionFood]; //have to look what will happen here
		
			break;
			case 0:
				tierChances = [-1,5,20];
				tier3 = [events.village]; //have to make all :) 
				tier2 = [events.merchant, events.merchant];
				tier1 = [events.merchant, events.merchant]; //have to look what will happen here
		
			break;
		}
	
		//for all testing !! remove later
		tier3 = [events.fallenGood];
		tier2 = [events.fallenGood];
		tier1 = [events.fallenGood];
		event = generateFormTierList(tierChances,undefined, tier3,tier2, tier1);
	
	}
	
	#endregion
	
	var lengthRows = _length;
	
	var currentObject = 0;
	var numberObjectInCurrentColumn = 0;
	
	var notesInColumns = [];
	var objectAtNotes = [];
	
	var minNumberInColumn = 2;
	var maxNumberInColumn = min(_maxNumberInColumn, 5);
	
	var probabilityQuestion = _probabilityQuestion;
	var probabilityQuestionGood  = _probabilityQuestionGood;
	var probabilityElite = _probabilityElite;
	
	for(var currentRow = 0; currentRow < lengthRows; currentRow ++){
		
		var numberObjectInCurrentColumn = 0;
		
		if(currentRow == 0){
			numberInCulumn =  4;
			notesInColumns[currentRow] = numberInCulumn;
				
			//finds position XY and splits them for X and Y
			var xyCords = findPositionMap(currentRow, notesInColumns[currentRow]);
			var positonsXCords = [];
			var positonsYCords = [];
			for(var j = 0; j < numberInCulumn; j ++){
				positonsXCords[j] = xyCords[0][j];
				positonsYCords[j] = xyCords[1][j];
			}
					
			for(i = 0; i < numberInCulumn; i ++){
				objectAtNotes[currentObject] = new mapNote(positonsXCords[i], positonsYCords[i], [],noteTypes.enemy, currentObject);
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
				//can be condensed very hard --> a lot of same code
				//--> is good has be reworked anyway to make the lines + Lock when Unavalibe 
				
				
				//have to add preNotes  i dont know the math behind it yet 
				preNotes = [];
				
				//will rework later to use tier system : ) 
				//and encounter are given tiers --> 
				//elits are tier 4, campfire tier 3, ...
				var encounter = random(1);
				if(encounter < probabilityElite){
					// here is a elite 
					objectAtNotes[currentObject] = new  mapNote(positonsXCords[i], positonsYCords[i], preNotes,noteTypes.elite, currentObject);
					numberObjectInCurrentColumn ++;
					currentObject ++;
					
				}else if((encounter * 2 )< probabilityQuestion){
					// here is a question 
					//when do neutrals happen ?????? have to look into later !!!!
					if(random(1) < probabilityQuestionGood){
						//objectAtNotes[currentObject] = new mapNoteCreate(positonsXCords[i], positonsYCords[i],preNotes, noteTypes.question, currentObject, generateRandomEvent(1));
						objectAtNotes[currentObject] = new mapNote(positonsXCords[i], positonsYCords[i], preNotes,noteTypes.question, currentObject, events.fallenGood);
						numberObjectInCurrentColumn ++;
						currentObject ++;
					}else{
						//objectAtNotes[currentObject] = new mapNoteCreate(positonsXCords[i], positonsYCords[i],preNotes, noteTypes.question, currentObject, generateRandomEvent(-1));
						objectAtNotes[currentObject] = new mapNote(positonsXCords[i], positonsYCords[i],preNotes, noteTypes.question, currentObject, events.fallenGood);
						numberObjectInCurrentColumn ++;
						currentObject ++;
					}
		
		
				}else{
					//here is a enemy 
					/*
					spawer = objects[currentObject];
					objectAtNotes[currentObject] = new mapNoteCreate(positonsXCords[i], positonsYCords[i],preNotes, noteTypes.enemy,currentObject);
					numberObjectInCurrentColumn ++;
					currentObject ++;
					*/
					//testcode 
					objectAtNotes[currentObject] = new mapNote(positonsXCords[i], positonsYCords[i],preNotes, noteTypes.campfire,currentObject);
					numberObjectInCurrentColumn ++;
					currentObject ++;
				}
			}
		
		}
			
	}
	
	map = new map(lengthRows, notesInColumns, objectAtNotes);
	return map;
}

//_probabilityTiersMapNotes --> How likely a tier is 
	//Tier 4 --> Elites 
	//Tier 3 --> Campfire
	//Tier 2 --> Questionmark
	//Tier 1 --> Normalfight
//_probabilityQuestionEventsGoodBad --> How like it is to have a good/ bad Map Event 
	//Tier 3 --> Bad Event --> Infection
	//Tier 2 --> neutral --> Campfire --> (new event "night falls and your party descides to make camp for the night"
	//Tier 1 --> Good Event -- > Fallen Goods
//maxNumer/minNumers --> is a given minumum for some notetypes 
	//[elites, campfire, questions] --> can be left emty --> Or -1 if the limit is not used 
function generateMap2electrikBoogalo(_length, _linesInMap, _probabilityTiersMapNotes, 
_probabilityQuestionEvents = [-1,10,30], _minNumers = [-1, -1, -1], _maxNumers = [-1, -1, -1]){
	randomize();
	
	#region var Funtions 

	#region findPositionMap
	
	//find a position for the given row and  number in column
	//x and y are first fixed but will be moved by a small amout 
	var findPositionMap = function(_row, _numberInColumn){
		randomize();
		var xRow = 192 * _row + 64; 	
		var yDIff = 592 / _numberInColumn;
	
		var xCords = [];
		var yCords = [];
		for(i = 0; i < _numberInColumn; i ++) {
			xCords[i] = xRow + ceil(random_range(- 15, 15));
			yCords[i] = yDIff * i + 64 + ceil(random_range(- 15, 15));
		
		}
		var xyCords = [xCords, yCords];
		return xyCords;
	}
	
	#endregion

	#region structs 
	
	//a struct that is used to save the map 
	//it saves its x,y,type and 1 other variable(is the event good or bad for Questions)
	var mapNote = function(_xCord, _yCord, _preNotes, _typeOfNote, _position, _specific = -1) constructor{
		xCord = _xCord;
		yCord = _yCord;
		typeOfNote = _typeOfNote;
		positionInList = _position;
		specific = _specific;
		preNotes = [];
		for(var i = 0; i < array_length(_preNotes); i ++){
			preNotes[i] = _preNotes[i];
		}
		subImage = 0;
	}

	//a strct that is a save for the map --> length, number of notes, and objects of the notes 
	//is used to generate the same map again after battle or other
	//generate Map
	var map = function(_length, _notesInColumns, _objectAtNotes) constructor{
		length = _length;
		notesInCloumns = [];
		for(var i = 0; i < array_length(_notesInColumns); i++){
			notesInCloumns[i] = _notesInColumns[i];
		}
		objectAtNotes = [];
		for(i = 0; i < array_length(_objectAtNotes); i++){
			objectAtNotes [i] = _objectAtNotes[i];
		}
	
	}
	
	#endregion

	#region generateRandomEvent
	
	//retuns a random event for a question
	//is given 1|0|-1 for good|neutral|bad 
	var generateRandomEvent = function(_eventKind){
		var tierChances = _probabilityQuestionEvents;
		var tier3 = [];
		var tier2 = [];
		var tier1 = [];
		switch(_eventKind){
			case 1:
				tierChances = [-1,10,30];
				//does this even work ? very funny if does saves like 200 lines lul
				tier3 = [events.fallenGood]; //have to make all :) 
				tier2 = [events.campfire, events.merchant];
				tier1 = [events.campfire, events.merchant]; //have to look what will happen here
			break;
			case -1:
				tierChances = [-1,10,20];
				tier3 = [events.infection]; //have to make all :) 
				tier2 = [events.ambush, events.poisionFood];
				tier1 = [events.ambush, events.poisionFood]; //have to look what will happen here
			break;
			case 0:
				tierChances = [-1,5,20];
				tier3 = [events.village]; //have to make all :) 
				tier2 = [events.merchant, events.merchant];
				tier1 = [events.merchant, events.merchant]; //have to look what will happen here
		
			break;
		}
	
		//for all testing !! remove later
		tier3 = [events.fallenGood];
		tier2 = [events.fallenGood];
		tier1 = [events.fallenGood];
		event = generateFormTierList(tierChances,undefined, tier3,tier2, tier1);
	
	}
	
	#endregion
	
	#region generateRandomNote 
	
	var generateRandomNotetype = function(){
		//note there might be a problem here
		var tierChances = _probabilityTiersMapNotes;
		var tier4 = [noteTypes.elite];
		var tier3 = [noteTypes.campfire];
		var tier2 = [noteTypes.question];
		var tier1 = [noteTypes.enemy];
		
		return generateFormTierList(tierChances, tier4, tier3, tier2, tier1); 
	}
	
	#endregion
	
	#region checkIfNoteTypeVaild
	
	var checkIfNoteTypeVaild = function(_noteType, _lineToCheck){
		var numberOfLookedType = 0;
		for(var i = 0; i < array_length(_lineToCheck); i ++){
			if(_lineToCheck[i].typeOfNote == _noteType){
				numberOfLookedType ++;	
			}
		}
		var valid = true;
		var indexInMaxNumers = (_noteType == noteTypes.elite) ? 0: (_noteType == noteTypes.campfire)? 1: 2;
		valid = (numberOfLookedType >= _maxNumers[indexInMaxNumers]) ? false : true;
		return valid;
	}
	
	#endregion
	
	#endregion

	//returns a map struct with all the information 
	var returnMap = -1
	
	#region calculates the numbers for all the rows
	
	//	var numberInRow = (currentRow == 0)? _linesInMap : _linesInMap round(random_range(-1,1)); 
	
	//the first one will be added last --> 
		//first all note but first are made then shuffle 
		//if its a boss add in last
	var numerInColumns = [];
	numerInColumns[0] = _linesInMap;
	for(var i = 1; i < _length; i ++){
		numerInColumns[i] = _linesInMap + round(random_range(-1, 1));
	}
	var numerInColumnsPassicCounter = array_create(_length, 0);
	
	#endregion

	//saves all the lines 
	var lines = [];
	
	for(var i = 0; i < _linesInMap + 1 ; i ++){
	
		#region generte a single Line 
		//generates a random line for the map Only sets the type 
			//other --> position + x/yCord + preNotes Later when all lines are created 
		var line = [];
		
		//generates random notes for all but the first
		//sets the position in the line -1 IF the maxNumber is reached 
		for(var j = 0; j < _length - 1; j ++){
			//sets the type of the numer 
			if(numerInColumnsPassicCounter[j] >= numerInColumns[j]){
				var noteType = generateRandomNotetype;
				while(checkIfNoteTypeVaild(noteType, line) == false){
					noteType = generateRandomNotetype;
				}
				numerInColumnsPassicCounter[j] ++; 
				line[j] = new mapNote(-1, -1, [], noteType, -1);
			}else{
				line[j] =  -1;
			}
			//addes the first not (always a fight)
			var firstNote = new mapNote(-1, -1, [], noteTypes.enemy, -1);
			array_insert(line, 0,firstNote); 
		}
		
		#endregion	
	
		//now a line gets put into lines 
			// [[],[]] --> 
			//now addes all the number for the objects 
			//its should stay 100% 
		array_insert(lines, i, line);
		
	}
	//lines is now a full construct of lines 
		
	//now all the x/yCords are set 
	for(var currentRow = 0; currentRow < _length; j ++){
		var xyCords = findPositionMap(currentRow, numerInColumns[currentRow]);
		for(var i = 0; i < numerInColumns[currentRow]; i ++){
			if(lines[i, currentRow] != -1){
				lines[i, currentRow].xCord = xyCords[0, i];
				lines[i, currentRow].yCord = xyCords[1, i];
			}
		}
	}
	
	
	
	//this is to set all the positions is the last thing in the system
	var fullNumerOfMapNotes = 0;
	for(var k = 0; k < array_length(lines[i]); k ++){
		if(lines[i, k] != -1){
			lines[i, k].positionInList = fullNumerOfMapNotes;
			if(lines[i, k].typeOfNote == noteTypes.question){
				lines[i, k].specific = generateRandomEvent();
			}
			fullNumerOfMapNotes ++;
		}
	}
	
	returnMap = new map();
	
	return returnMap;
}

//is used to display a given map 
//is used when returning to the map 
function displayMap(_map){
	
	#region addVariablsToCreation
	
	//adds all current Variabls to a MapObject 
	//position, specific and preNotes
	var addVariablsToCreation = function(_creation, _currentObject, _currentNote){
		_creation.positionInList = _currentObject;
		for(var i = 0; i < array_length(_currentNote.preNotes); i ++){
			_creation.preNotes[i] = _currentNote.preNotes[i]
		}
	}
	
	#endregion
	
	for(var currentObject = 0; currentObject < array_length(_map.objectAtNotes); currentObject ++){
		var currentNote = _map.objectAtNotes[currentObject];
		switch(currentNote.typeOfNote){
			case noteTypes.enemy:
				var creation = instance_create_depth(currentNote.xCord,currentNote.yCord, 0, oMapEnemy);
				creation.changeSprite(currentNote.xCord, currentNote.yCord,MapEnemy,false,false);	
			break;
			case noteTypes.elite:
				var creation = instance_create_depth(currentNote.xCord, currentNote.yCord, 0, oMapEnemyElite);
				creation.changeSprite(currentNote.xCord, currentNote.yCord,MapEnemyElite,false,false);
			break;
			case noteTypes.question:
				var creation = instance_create_depth(currentNote.xCord, currentNote.yCord,0, oMapQuestion);
				creation.changeSprite(currentNote.xCord, currentNote.yCord,MapQuestion,false,false);
				creation.event = currentNote.specific;
			break;
			case noteTypes.campfire:
				var creation = instance_create_depth(currentNote.xCord, currentNote.yCord,0, oMapCampfire);
				creation.changeSprite(currentNote.xCord, currentNote.yCord,MapCampfire,false,false);
			break;
		}
		addVariablsToCreation(creation,currentObject, currentNote);
		creation.setUseHighlightHoverImage(MapHover);
		
	}
}

