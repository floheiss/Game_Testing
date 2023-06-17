//wip
if(!global.map){
	contract = global.contract;
	
	global.map = generateMap(contract.mapLength, contract.mapLinesInMap,
	contract.mapProbabilityTiersMapNotes,
	contract.mapProbabilityProbabilityQuestionEvents,
	contract.mapMinNumers, contract.mapMaxNumers);
}

if(global.room == rDungeonMap){
	displayMap(global.map);
}


//sets the enemies for oGame 
//is based on the set _enemyStrength (0 norma) (1 elite) (2 boss)
	//will be changed later :(
//sets the number to be playerGroup (+1)
function genrateEnemys(_enemyStrength){
	//numberOfEnemies is playerGroup (+1)  
	var numberOfEnemies = (checkAgainstRandom100(70))? 1: 0;
	if(_enemyStrength == 2){
		numberOfEnemies = 1;
	}else{
		var numberFilledSlots = 0;
		for(var i = 0; i < array_length(global.playerGroup); i ++){
			numberFilledSlots += (global.playerGroup[i] != -1)? 1 : 0;
		}
		numberOfEnemies += numberFilledSlots;
	}
	
	var exidedFive = false;
	if(numberOfEnemies > 5){
		numberOfEnemies = 5;
		exidedFive = true;
	}

	//what enemies can be spawned;
	var pollOfEnemies = [];
	
	#region generatePoll 
	
	var generatePoll = function(_dungeonType, _enemyStrength){ 
		var enemyPoll = [];
		switch(_dungeonType){
			#region woods
			case dungeonTyps.woods:
				switch(_enemyStrength){
					case 2:
						enemyPoll[0] = oBandit;//oBanditLeader
					break;
					case 1:
						enemyPoll[0] = oBandit;//oBanditRaider
						enemyPoll[1] = oBandit;//oBanditHound
						enemyPoll[2] = oBandit;
					break;
					case 0:
						enemyPoll[0] = oBandit;//oBanditRaider
						enemyPoll[1] = oBandit;//oBanditHound
						enemyPoll[2] = oBandit;//oBandit
						enemyPoll[3] = oBandit;//oBanditUnderling
					break;
				}
			break;
			#endregion
		}
		return enemyPoll;
	}
	
	#endregion
	
	pollOfEnemies = generatePoll(global.contract.dungeonType, _enemyStrength);
	
	
	for(var i = 0; i < numberOfEnemies; i++){
		var genEnemy = findRandomItemInArray(pollOfEnemies)
		global.enemies[i] = instance_create_depth(0,0,0, genEnemy);
	}
	
}

//wip
//creates a loot --> based on own dungeon, difficutly
function generateLoop(){

}