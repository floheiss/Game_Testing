//wip
if(!global.map){
	contract = global.contract;
	
	global.map = mMapGenerator.generateMap(contract.mapLength,
	contract.mapMaxNumberInColumn,
	contract.mapProbabilityQuestion,
	contract.mapProbabilityQuestionGood,
	contract.mapProbabilityElite);
}

if(room_get_name(room) == "rDungeonMap"){
	mMapGenerator.displayMap(global.map);
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