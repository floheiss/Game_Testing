event_inherited();

contracts = [];

drawInGui = false;
drawInMap = true;

changeSprite(x,y,sprite_index);

//generatesContracts for the display in Guild
MainFunction = function(){
	
	var generateContracts = function(){
	randomize();
	contracts = [];
	
	#region contractStruct
	
	//constructor for full contract
	//_difficulty enemyDifficulty 
	//_dungeonType = where the dungeon is 
	//_contractType = [0,1] saves the type of contract and extra info needed 
	//_reward = the reward for the contract 
	//_description = [] for text description of the contract
	//_mapInfo = [] with all infos for a map 
	var createContract = function(_difficulty, _dungeonType, _contractType, _reward, _description,_mapInfo, _extra = -1) constructor{
		mapLength = _mapInfo[0];
		mapMaxNumberInColumn = _mapInfo[1];
		mapProbabilityQuestion = _mapInfo[2];
		mapProbabilityQuestionGood = _mapInfo[3];
		mapProbabilityElite = _mapInfo[4];
	
		difficulty = _difficulty;
		dungeonType = _dungeonType;
	
		contractType = _contractType[0];
		contractTypeExtraInfo = _contractType[1];
	
		reward = _reward;
	
		descriptionTitle = _description[0];
		descriptionMission = _description[1];
	
	
		extra = _extra;
	}
	
	#endregion
	
	#region randomDungeonType
	
	//returns a random dungeonType
	//can be given an array or only 1 number of limitations 
	//must array bust be smaller then 5 (0-4)
	//full rework | only 1 dungeon for now 
	var randomDungeonType = function(_limitation = -1){
		randomize();
		maxRoll = 4;
		dungeonType = round(random_range(0,maxRoll));
	
		if(_limitation != -1){
			if(is_array(_limitation)){
				_predicate = function (_value){
					return _value == dungeonType;
				}
				while(array_find_index(_limitation, _predicate)){
					dungeonType = round(random_range(0, maxRoll));
				}
			}else{
				while(_limitation == dungeonType){
					dungeonType = round(random_range(0,maxRoll));
				}
			}
		}
	
		switch(dungeonType){
			case 0:
				dungeonType = dungeonTyps.woods;
			break;
			case 1:
				dungeonType = dungeonTyps.gravyard;
			break;
			case 2:
				dungeonType = dungeonTyps.goblinChamp;
			break;
			case 3:
				dungeonType = dungeonTyps.underwater;
			break;
			case 4:
				dungeonType = dungeonTyps.banditChamp;
			break;
			default: 
				dungeonType = dungeonTyps.goblinChamp;
			break;
		}
	
		return dungeonType;
	}

	#endregion
	
	#region randomContractType
	
	//returns a random contractType
	//can be given an array or only 1 number of limitations 
	//must array bust be smaller then 4 (0-3)
	//HAVE TO LOOK AT LIMITATIONS NOT WORKING FK THIS ARRAY STUFF
	//collect has to be added (not sure) (calculations) :) 
	//killEnemys has to think about (calculations) :) 
	//full rework | only 1 dungeonType for now 
	var randomContractType = function(_dungeonType, _exploreMin = 0.5,_exploreMax = 0.8, _limitation = -1){
		randomize();
		maxRoll = 3;
		contractType = [];
		contractType[0] = round(random_range(0,maxRoll));
		contractType[1] = 0;
	
		if(_limitation != -1){
			if(is_array(_limitation)){
				_predicate = function (_value){
					return _value == contractType[0];
				}
				while(array_find_index(_limitation, _predicate)){
					contractType[0] = round(random_range(0,maxRoll));
				}
			}else{
				while(_limitation == contractType[0]){
					contractType[0] = round(random_range(0,maxRoll));
				}
			}
		}
	
		switch(contractType[0]){
			case 0:
				contractType[0] = contracTyps.boss;
				target = random(1);
				switch(_dungeonType){
					case dungeonTyps.woods:
						if(target < 0.3){
							contractType[1] = enemyTyps.spider;
						}else if(target < 0.45){
							contractType[1] = enemyTyps.bandits;
						}else if(target < 0.6){
							contractType[1] = enemyTyps.goblins;
						}else{
							contractType[1] = enemyTyps.beast;
						}
					break;
					case dungeonTyps.gravyard:
						if(target < 0.5){
							contractType[1] = enemyTyps.skeleton;
						}else if(target < 0.7){
							contractType[1] = enemyTyps.ghost;
						}else{
							contractType[1] = enemyTyps.bandits;
						}
					break;
					case dungeonTyps.goblinChamp:
						contractType[1] = enemyTyps.goblins;
					break;
					case dungeonTyps.underwater:
						contractType[1] = enemyTyps.mermaid;
					break;
					case dungeonTyps.banditChamp:
						contractType[1] = enemyTyps.bandits;
					break;
					default:
						contractType[1] = enemyTyps.bandits;
					break;
				}
			break;
		
			case 1:
				contractType[0] =  contracTyps.collect;
				contractType[1] = random_range(0.5,0.7);
			break;
		
			case 2:
				contractType[0] =  contracTyps.defeatEnemys;
			break;
		
			case 3:
				contractType[0] = contracTyps.exlore;
				contractType[1] = random_range(_exploreMin, _exploreMax);
			break;
		
			default: 
				contractType[0] = contracTyps.boss;
			break;
		}
	
		return contractType;
	}

	#endregion
	
	#region randomMapInfo
	
	//returns random mapinfo based on the difficulty and contractType
	//_contractType has to be implimnted not sure how yet
	//not sure if need to rework
	var randomMapInfo = function(_difficulty, _contractType){
		var mapInfo = [];
		switch(_difficulty){
			case enemyDifficulty.easy:
				mapInfo[0] = round(random_range(5, 6)); //mapLength
				mapInfo[1] = 3;							//mapMaxNumberInColumn
				mapInfo[2] = random_range(1, 0.3);	//mapProbabilityQuestion
				mapInfo[3] = random_range(0.65, 0.8);	//mapProbabilityQuestionGood
				mapInfo[4] = random_range(0.05, 0.15);	//mapProbabilityElite
			break;
			case enemyDifficulty.normal:
				mapInfo[0] = round(random_range(6, 8));
				mapInfo[1] = 4;
				mapInfo[2] = random_range(1, 0.3);
				mapInfo[3] = random_range(0.50, 0.7);
				mapInfo[4] = random_range(0.1, 0.2);
			break;
			case enemyDifficulty.hard:
				mapInfo[0] = round(random_range(9,10));
				mapInfo[1] = 5;
				mapInfo[2] = random_range(1, 0.3);
				mapInfo[3] = random_range(0.5, 0.7);
				mapInfo[4] = random_range(0.15, 0.3);
			break;
		}
	
		return mapInfo;
	}
	
	#endregion
	
	#region randomDescription
	
	//returns a description based on the difficulty, dungeontype contracttype and reward 
	//is an array used for text displaying
	//might need rework ??????
	var randomDescription = function(_dungeonType, _contractType){
		var description = [];
		var title = "something went wrong";
		var mission = ": )))))"
		//generate the titple 
		//pls changed all the fking titles thx : )
		//guild girls is telling you this so she likes money 
		switch(_contractType[0]){
			case contracTyps.boss:
				switch(_contractType[1]){
					case enemyTyps.spider:
						title = "The spider queen is on rampage";
						mission = "Finish her of";
					break;
					case enemyTyps.bandits:
						title = "Bantis are cuting into my profits. Stop that";
						mission = "You've done this befor, take there loot back or just kill them";
					break;
					case enemyTyps.goblins:
						title = "Goblins are stealing valuables. Thats my job";
						mission = "Take them back or kill some of them at least";
					break;
					case enemyTyps.beast:
						title = "Some kid got gut in the forest. People are scared and not spending money";
						mission = "kill wolfs or what ever you find there";
					break;
					case enemyTyps.skeleton:
						title = "There are skeleton in the graveyard. My graverobbers cant do there job";
						mission = "put there bones back in the graves";
					break;
					case enemyTyps.ghost:
						title = "Some ghost awoke form death. If people arent geting burried what can a graverobbers take";
						mission = "Go be a trained ghosthunter or something";
					break;
					case enemyTyps.mermaid:
						title = "The mermaid queen has some relicts I want";
						mission = "Go in her layer, steal them and maybe kill her";
					break;
				}
			break;
			case contracTyps.collect:
				switch(_dungeonType){
					case dungeonTyps.woods:
						title = "The local idiots need some beast hides";
						mission = "Be a deer and get me some of them. Yes will get some of the profits";
					break;
					case dungeonTyps.gravyard:
						title = "Graverobbing, you ever tried it ?";
						mission = "My last guy joined his clientel. You wanna meet him ?";
					break;

					case dungeonTyps.goblinChamp:
						title = "Goblin Champ title";
						mission = "Goblin Champ Mission collect";
					break;
					case dungeonTyps.underwater:
						title = "Underwater title";
						mission = "Underwater Mission collect";
					break;
					case dungeonTyps.banditChamp:
						title = "Bandits title";
						mission = "Bandits Mission collect";
					break;
				}
			break;
		
			case contracTyps.defeatEnemys:
				switch(_dungeonType){
					case dungeonTyps.woods:
						title = "forest title";
						mission = "forest Mission defeatEnemys";
					break;
					case dungeonTyps.gravyard:
						title = "Gravyard title";
						mission = "Gravyard Mission defeatEnemys";
					break;
					case dungeonTyps.goblinChamp:
						title = "Goblin Champ title";
						mission = "Goblin Champ Mission defeatEnemys";
					break;
					case dungeonTyps.underwater:
						title = "Underwater title";
						mission = "Underwater Mission defeatEnemys";
					break;
					case dungeonTyps.banditChamp:
						title = "Bandits title";
						mission = "Bandits Mission defeatEnemys";
					break;
				}
			break;
		
			case contracTyps.exlore:
				switch(_dungeonType){
					case dungeonTyps.woods:
						title = "forest title";
						mission = "forest Mission explore";
					break;
					case dungeonTyps.gravyard:
						title = "Gravyard title";
						mission = "Gravyard Mission explore";
					break;
					case dungeonTyps.goblinChamp:
						title = "Goblin Champ title";
						mission = "Goblin Champ Mission explore";
					break;
					case dungeonTyps.underwater:
						title = "Underwater title";
						mission = "Underwater Mission explore";
					break;
					case dungeonTyps.banditChamp:
						title = "Bandits title";
						mission = "Bandits Mission explore";
					break;
				}
			break;
		}
		description[0] = title;
		description[1] = mission;
		return description;
	}
	
	#endregion
	
	var deBugLimitContracts = [1,2,3];
	
	#region contract Gen
	
	//contract 1 
	var difficulty = enemyDifficulty.easy;
	var dungeonType = randomDungeonType([1,3,4]);
	var contractType = randomContractType(dungeonType, 0.3, 0.5, deBugLimitContracts);
	var reward = 100 + round(random_range(20, 70));
	var description = randomDescription(dungeonType, contractType);
	var mapInfo = randomMapInfo(difficulty, contractType);
	
	contracts[0] = new createContract(difficulty, dungeonType, contractType, reward, description,mapInfo);
	
	//contract 2
	//should be harder then 1 
	difficulty = enemyDifficulty.easy;
	dungeonType = randomDungeonType([0,1,2]);
	contractType = randomContractType(dungeonType,0.4,0.6,deBugLimitContracts);
	reward = 130 + round(random_range(30, 50));
	description = randomDescription( dungeonType, contractType);
	mapInfo = randomMapInfo(difficulty, contractType);
	
	contracts[1] = new createContract(enemyDifficulty.easy, dungeonType, contractType, reward, description,mapInfo);
	
	//contract 3
	difficulty = enemyDifficulty.normal;
	dungeonType = randomDungeonType();
	contractType = randomContractType(dungeonType,0.6,0.65,deBugLimitContracts);
	reward = 200 + round(random_range(10, 40));
	description = randomDescription( dungeonType, contractType);
	mapInfo = randomMapInfo(difficulty, contractType);
	
	contracts[2] = new createContract(enemyDifficulty.normal, dungeonType, contractType, reward, description,mapInfo);
	
	//contract 4
	//should be harder then 3
	difficulty = enemyDifficulty.normal;
	dungeonType = randomDungeonType();
	contractType = randomContractType(dungeonType,0.55,0.7,deBugLimitContracts);
	reward = 230 + round(random_range(30, 50));
	description = randomDescription( dungeonType, contractType);
	mapInfo = randomMapInfo(difficulty, contractType);
	
	contracts[3] = new createContract(enemyDifficulty.normal, dungeonType, contractType, reward, description,mapInfo);
	
	//contract 5
	difficulty = enemyDifficulty.hard;
	dungeonType = randomDungeonType();
	contractType = randomContractType(dungeonType, 0.65,0.75,deBugLimitContracts);
	reward = 300 + round(random_range(10, 40));
	description = randomDescription( dungeonType, contractType);
	mapInfo = randomMapInfo(difficulty, contractType);
	
	contracts[4] = new createContract(difficulty, dungeonType, contractType, reward, description,mapInfo);
	
	//contract 6
	//should be harder then 5
	difficulty = enemyDifficulty.hard;
	dungeonType = randomDungeonType();
	contractType = randomContractType(dungeonType,0.65,0.8,deBugLimitContracts);
	reward = 330 + round(random_range(30, 50));
	description = randomDescription( dungeonType, contractType);
	mapInfo = randomMapInfo(difficulty, contractType);
	
	contracts[5] = new createContract(difficulty, dungeonType, contractType,reward, description,mapInfo);
	#endregion
	
	contracts = array_shuffle(contracts);
	
	return contracts;
	
}

	if(oTown.currentMenu == -1){
		if(global.contract != false or array_length(contracts) < 6){
		generateContracts();
	}
		with(oTown){
			currentMenu = menus.guild;
			displayMenuInTown();
		}	

	}
}



