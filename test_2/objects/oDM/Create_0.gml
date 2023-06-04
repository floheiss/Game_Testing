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


function generateEncounter(enemyStrength){
	//enemies = genrateEnemys(enemyStrength);
	global.playerGroup = [oSamurai,oSamuraiArcher, oSamuraiCommander];
	global.enemies = [oSamurai, oSamuraiCommander];
	room_goto(rBattleScreen);
}

//wip
//calculates a point value for the playGroup and enemies based on it 
//creates a enemy list --> based on own groug(strenght number), dungeon type, difficulty 
//gets all the params form the contract (hardcode now)

function genrateEnemys(enemyStrength){
	enemies = [];
	//global.playerGroup;
	
	
	
	return enemies;
}

//wip
//creates a loot --> based on own dungeon, difficutly
function generateLoop(){

}