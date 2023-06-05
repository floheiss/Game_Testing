//_probabilityTiersMapNotes --> How likely a tier is 
	//Tier 4 --> Elites 
	//Tier 3 --> Campfire
	//Tier 2 --> Questionmark
	//Tier 1 --> Normalfight
//_probabilityQuestionEventsGoodBad --> How like it is to have a good/ bad Map Event 
	//Tier 3 --> Bad Event --> Infection
	//Tier 2 --> neutral --> Campfire --> (new event "night falls and your party descides to make camp for the night"
	//Tier 1 --> Good Event -- > Fallen Goods
//maxnumber/minnumbers --> is a given minumum for some notetypes 
	//[elites, campfire, questions, normalEnemies] --> can be left emty --> Or -1 if the limit is not used 
function generateMap(_length, _linesInMap, _probabilityTiersMapNotes, 
_probabilityQuestionEvents = [-1,20,30], _minNumbers = [0, 0, 0, 0], _maxNumbers = [100, 100, 100]){
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
		for(var i = 0; i < _numberInColumn; i ++) {
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
	var map = function(_length, _notesInColumns, _lines) constructor{
		length = _length;
		notesInCloumns = [];
		for(var i = 0; i < array_length(_notesInColumns); i++){
			notesInCloumns[i] = _notesInColumns[i];
		}
		
		//is all the objects order by position in the lines
		objectAtNotes = [];
		
		numberOfElits = 0;
		numberOfCampfire = 0;
		numberOfQuestion = 0;
		numberOfNormalEnemies = 0;
		
		var currentObject = 0;
		for(var i = 0; i <  length; i++){
			for(var j = 0; j < notesInCloumns[i]; j ++){
				var note = _lines[j, i];
				if(note != -1){
					objectAtNotes[currentObject] = note;
					currentObject ++;
					switch(note.typeOfNote){
						case noteTypes.elite:
							numberOfElits ++;
						break;
						case noteTypes.question:
							numberOfQuestion ++;
						break; 
						case noteTypes.campfire:
							numberOfCampfire ++;
						break;
						case noteTypes.enemy:
							numberOfNormalEnemies ++;
						break;
					}
					
				}	
			}
		}
	}
	
	#endregion

	#region generateRandomEvent
	
	//retuns a random event for a question
	//is given 1|0|-1 for good|neutral|bad 
	var generateRandomEvent = function(_eventKind, _probabilityQuestionEvents){
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
		var event = generateFormTierList(tierChances,undefined, tier3,tier2, tier1);
		return event;
	}
	
	#endregion
	
	#region generateRandomNote 
	
	var generateRandomNotetype = function(_probabilityTiersMapNotes){
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
	
	var checkIfNoteTypeVaild = function(_noteType, _lineToCheck, _maxNumbers){
		var numberOfLookedType = 0;
		for(var i = 0; i < array_length(_lineToCheck); i ++){
			if(_lineToCheck[i] != -1){
				if(_lineToCheck[i].typeOfNote == _noteType){
					numberOfLookedType ++;	
				}
			}
		}
		var valid = true;
		var indexInMaxNumbers = 0; 
		switch(_noteType){
			case noteTypes.elite:
				indexInMaxNumbers = 0;
			break;
			case noteTypes.campfire:
				indexInMaxNumbers = 1;
			break;
			case noteTypes.question:
				indexInMaxNumbers = 2;
			break;
		}
		valid = (numberOfLookedType <= _maxNumbers[indexInMaxNumbers]) ? false : true;
		if(_noteType == noteTypes.campfire && array_length(_lineToCheck) > 0 &&_lineToCheck[array_length(_lineToCheck) - 1] != -1){
			if(_lineToCheck[array_length(_lineToCheck) - 1].typeOfNote == noteTypes.campfire){
				valid = false;
			}
		}
		return valid;
	}
	
	#endregion
	
	#region checkIfLineVaild
	
	var checkIfLineVaild = function(_line, _minInLine){
		var validElits = false;
		var validCampFire = false;
		var validQuestion = false;
		var validNormal = false;
		
		var numberElits = 0;
		var numberCampFire = 0;
		var numberQuestion = 0;
		var numberNormalEnemies = 0;
		
		for(var i = 0; i < array_length(_line); i ++){
			var note = _line[i];
			if(note != -1){
				switch(_line[i].typeOfNote){
					case noteTypes.elite: 
						numberElits ++;
					break;
					case noteTypes.campfire: 
						numberCampFire ++;
					break;
					case noteTypes.question: 
						numberQuestion ++;
					break;
					case noteTypes.enemy:
						numberNormalEnemies ++;
					break;
				}
			}
			
		}
				
		#region the if if now vaild 
			if(numberElits >= _minInLine[0]){
				validElits = true;
			}
			if(numberCampFire >= _minInLine[1]){
				validCampFire = true;
			}
			if(numberQuestion >= _minInLine[2]){
				validQuestion = true;
			}
			if(numberNormalEnemies >= _minInLine[3]){
				validNormal = true;
			}	
		#endregion
		
		while(!validElits && numberNormalEnemies > 1){
			if(numberElits >= _minInLine[0]){
				validElits = true;
				break;
			}
			
			if(!validElits){
				for(var i = 0; i < array_length(_line); i ++){
					var randomSpot = round(random_range(1, array_length(_line) - 1));
					var note = _line[randomSpot];
					if(note != -1 && note.typeOfNote == noteTypes.enemy && i > 0){
						_line[randomSpot].typeOfNote = noteTypes.elite;
						numberElits++;
						numberNormalEnemies --;
						break;
					}
				}
			}
			
		}

		while(!validCampFire && numberNormalEnemies > 1){
			if(numberCampFire >= _minInLine[1]){
				validCampFire = true;
				break;
			}
			if(!validCampFire){
				for(var i = 0; i < array_length(_line); i ++){
					var randomSpot = round(random_range(1, array_length(_line) - 1));
					var note = _line[randomSpot];
					if(note != -1 && note.typeOfNote == noteTypes.enemy && i > 0){
						_line[randomSpot].typeOfNote = noteTypes.campfire;
						numberCampFire ++;
						numberNormalEnemies --;
						break;
					}
				}
			}
		}

		while(!validQuestion && numberNormalEnemies > 1){
			if(numberQuestion >= _minInLine[2]){
				validQuestion = true;
				break;
			}
			if(!validQuestion){
				for(var i = 0; i < array_length(_line); i ++){
					var randomSpot = round(random_range(1, array_length(_line) - 1));
					var note = _line[randomSpot];
					if(note != -1 && note.typeOfNote == noteTypes.enemy && i > 0){
						_line[randomSpot].typeOfNote = noteTypes.question;
						numberQuestion ++;
						numberNormalEnemies --;
						break;
					}
				}
			}
		}

		while(!validNormal){
			if(numberNormalEnemies >= _minInLine[3]){
				validNormal = true;
				break;
			}
			if(!validNormal){
				for(var i = 0; i < array_length(_line); i ++){
					var randomSpot = round(random_range(1, array_length(_line) - 1));
					var note = _line[randomSpot];
					if(note != -1 && note.typeOfNote != noteTypes.enemy && i > 0){
						_line[randomSpot].typeOfNote = noteTypes.enemy;
						numberNormalEnemies ++;
						break;
					}
				}
			}
		}
		
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
	var numberInColumns = [];
	numberInColumns[0] = _linesInMap;
	for(var i = 1; i < _length; i ++){
		numberInColumns[i] = _linesInMap + round(random_range(-1, 1));
	}
	var numberInColumnsPassicCounter = array_create(_length, 0);
	numberInColumnsPassicCounter[0] = _linesInMap;
	
	#endregion
	//saves all the lines 
	var lines = [];
	
	for(var i = 0; i < _linesInMap; i ++){
	
		#region generte a single Line 
		//generates a random line for the map Only sets the type 
			//other --> position + x/yCord + preNotes Later when all lines are created 
		var line = [];
		
		//its should stay 100% 
		//addes the first note (always a fight)
		var firstNote = new mapNote(-1, -1, [], noteTypes.enemy, -1, -1);
		line[0] =  firstNote;
		//generates random notes for all but the first
		//sets the position in the line -1 IF the maxNumber is reached 
		for(var j = 1; j < _length; j ++){
			//sets the type of the number 
			if(numberInColumnsPassicCounter[j] < numberInColumns[j]){
				
				var noteType = generateRandomNotetype(_probabilityTiersMapNotes);
	
				while(checkIfNoteTypeVaild(noteType, line, _maxNumbers) == false && noteType != noteTypes.enemy){
					noteType = generateRandomNotetype(_probabilityTiersMapNotes);
				}
				numberInColumnsPassicCounter[j] ++;
				
				line[j] = new mapNote(-1, -1, [], noteType, -1, -1);
			}else{
				line[j] =  -1;
			}
			
		}
		
		#endregion	
		
		checkIfLineVaild(line, _minNumbers);
		//now a line gets put into lines 
			// [[],[]] --> 
			//now addes all the number for the objects 
		array_insert(lines, i, line);
	}
	//here we create the last Line 
	
	#region the last line (this holds any overflow)
	//this will hold any overflow form numberInColumns (4 notes are wanted but only 3 lines exist)
	line = array_create(_length, -1);
	
	for(var i = 0; i < _length; i ++){
		if(numberInColumnsPassicCounter[i] < numberInColumns[i] && i > 0){
			var noteType = noteTypes.enemy;
			line[i] = new mapNote(-1, -1, [], noteType, -1);
		//	numberInColumnsPassicCounter[i] ++;
		}
	}
	array_insert(lines, _linesInMap, line);

	//lines is now a full construct of lines 
	#endregion
	
	//testing right here right now --> boss condtition :)
	#region additions for BossLayout
	if(global.contract.contractType == contracTyps.boss){
		//if the contracts is a boss then some additions have to be made 
			//campfire before boss + boss note + exit
	
	
		#region adding the campfires
		numberInColumns[_length] = _linesInMap;//the number in the colum of campfire is the one befor -1
	
		//addeds the line of campfires at the end
		//should work :) ????
		for(var i = 0; i < numberInColumns[_length]; i ++){
			lines[i, _length] = new mapNote(-1, -1, [], noteTypes.campfire, -1);
		}	
		#endregion
	
		#region adding the boss and ext 
	
		numberInColumns[_length+1] = 1;//the number in the colum of campfire is the one befor -1
		numberInColumns[_length+2] = 1;
	
		lines[0, _length+1]= new mapNote(-1, -1, [], noteTypes.boss, -1);
		lines[0, _length+2] = new mapNote(-1, -1, [], noteTypes.exitMap, -1);
	
		#endregion
		// +3 for campfire + boss + exit 
		_length += 3;
	}

	#endregion
	
	
	#region x/yCords + preNotes + numbering 
	//now all the x/yCords are set 
	//are set here as now all notes are assambled
	//gives all the notes a position form 0 - last note
	//this is to set all the positions is the last thing in the system
	//THIS ALSO SETS THE PRENOTES I DONT SEE WHERE THEY MIGHT HAVE PROBLEMS VERY HAPPY
	var fullnumberOfMapNotes = 0;
	for(var currentRow = 0; currentRow < _length; currentRow ++){
		var xyCords = findPositionMap(currentRow, numberInColumns[currentRow]);
		for(var i = 0; i < numberInColumns[currentRow]; i ++){
			var note = lines[i, currentRow];
			if(note != -1){
				#region x/yCords + numbering + questionmarkInfo
				note.xCord = xyCords[0, i];
				note.yCord = xyCords[1, i];
				
				note.positionInList = fullnumberOfMapNotes;
			
				if(note.typeOfNote == noteTypes.question){
				var eventKind = generateFormTierList(_probabilityQuestionEvents, undefined, [-1], [0], [1]);
					note.specific = generateRandomEvent(eventKind, _probabilityQuestionEvents);
				}
				#endregion
				
				if(currentRow > 0){
					var preLine = currentRow - 1;
					#region sets currentColumnIs
					//1| 0 | -1 
						//1 the current line is bigger 
						//-1 the current line is smaller
						//0 the current line is the same size
					var currentColumnIs = 0; 
					var befor = numberInColumns[preLine];
					var now = numberInColumns[currentRow];
					if(befor == now){
						currentColumnIs = 0;
					}else if(befor < now){
						currentColumnIs = 1;
					}else if(befor > now){
						currentColumnIs = -1;
					}
					
					#endregion
					
					#region fills preNotes basic
					switch(currentColumnIs){
						#region basic case
						case 0: 
							if(lines[i, preLine] != -1){
								note.preNotes[0] = lines[i, preLine];
							}
							//most basic thing no second line for now 
						break;
						#endregion
						
						#region current smaller
						case -1: 
							if(lines[i, currentRow - 1] != -1){
								if(i == 0){
									if(numberInColumns[currentRow] == 1){
										show_debug_message("i went into to dangerzone");
										//fixes if the were 3+ lines and now there is only 1 
										for(var j = 0; j < numberInColumns[preLine]; j++){
											note.preNotes[j] = lines[j, preLine];
										}
									}else{
										note.preNotes[0] = lines[i, preLine];
										note.preNotes[1] = lines[i + 1, preLine];
									}
								}else if((i+1) == numberInColumns[currentRow]){
									note.preNotes[0] = lines[numberInColumns[preLine] - 2, currentRow -1];
									note.preNotes[1] = lines[numberInColumns[preLine] - 1, currentRow -1];
									
								}else{
									note.preNotes[0] = lines[i, preLine];				
								}
							}
						break;
						#endregion
						
						#region current bigger
						case 1: 
							if(i == 0){
								note.preNotes[0] = lines[i, preLine];
								note.preNotes[1] = lines[i + 1, preLine];
							}else if((i+1) == numberInColumns[currentRow]){
								note.preNotes[0] = lines[(numberInColumns[preLine] - 2), preLine];
								note.preNotes[1] = lines[(numberInColumns[preLine] - 1), preLine];
							}else{
								note.preNotes[0] = lines[i, preLine];
								/*
								//should fix a small bug :) 
								while(note.preNotes[0].positionInList == note.positionInList){
									note.preNotes[0] = lines[i - 1, preLine];	
								}
								*/
									
							}
						break;
						#endregion
					}
					#endregion
					
					#region fills preNotes advanced
					if(i > 0 && ((i+1) < numberInColumns[currentRow])){
						var newMovmentLines = (checkAgainstRandom100(60))? 1: 0;
						for(var j = 0; j < newMovmentLines; j ++){
							var toWhere = (round(random_range(0,1)) == 1)? 1 : -1;
							note.preNotes[1] = lines[i + toWhere, preLine];	
						}
					}
					#endregion
				}
				fullnumberOfMapNotes ++;
			}
		}
	}
	#endregion
		
	returnMap = new map(_length, numberInColumns, lines);
	
	return returnMap;
}

//is used to display a given map 
//is used when returning to the map 
function displayMap(_map){
	#region addVariablsToCreation
	
	//adds all current Variabls to a MapObject 
	//position, specific and preNotes
	var addVariablsToCreation = function(_creation, _currentObject, _currentNote){
		if(_creation != -1){
			_creation.positionInList = _currentObject;
			for(var i = 0; i < array_length(_currentNote.preNotes); i ++){
				_creation.preNotes[i] = _currentNote.preNotes[i]
			}
		}
	}
	
	#endregion
	
	for(var currentObject = 0; currentObject < array_length(_map.objectAtNotes); currentObject ++){
		if(_map.objectAtNotes[currentObject] != -1){
			var currentNote = _map.objectAtNotes[currentObject];
			var creation = false; 
			switch(currentNote.typeOfNote){
				case noteTypes.enemy:
					creation = instance_create_depth(currentNote.xCord,currentNote.yCord, 0, oMapEnemy);
					creation.changeSprite(currentNote.xCord, currentNote.yCord,MapEnemy,false,false);	
				break;
				case noteTypes.elite:
					creation = instance_create_depth(currentNote.xCord, currentNote.yCord, 0, oMapEnemyElite);
					creation.changeSprite(currentNote.xCord, currentNote.yCord,MapEnemyElite,false,false);
				break;
				case noteTypes.question:
					creation = instance_create_depth(currentNote.xCord, currentNote.yCord,0, oMapQuestion);
					creation.changeSprite(currentNote.xCord, currentNote.yCord,MapQuestion,false,false);
					creation.event = currentNote.specific;
				break;
				case noteTypes.campfire:
					creation = instance_create_depth(currentNote.xCord, currentNote.yCord,0, oMapCampfire);
					creation.changeSprite(currentNote.xCord, currentNote.yCord,MapCampfire,false,false);
				break;
				case noteTypes.boss:
					creation = instance_create_depth(currentNote.xCord, currentNote.yCord,0, oMapBoss);
					creation.changeSprite(currentNote.xCord, currentNote.yCord,MapBoss,false,false);
				break;
				case noteTypes.exitMap:
						creation = instance_create_depth(currentNote.xCord, currentNote.yCord,0, oMapExitMap);
					creation.changeSprite(currentNote.xCord, currentNote.yCord,MapExit,false,false);
				break;
			}
			
			addVariablsToCreation(creation,currentObject, currentNote);
			creation.setUseHighlightHoverImage(MapHover);
		}
	}

}
