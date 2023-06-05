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
	var contract = function(_difficulty, _dungeonType, _contractType, _reward, _description,_mapInfo, _extra = -1) constructor{
		mapLength = _mapInfo[0];
		mapLinesInMap = _mapInfo[1];
		mapProbabilityTiersMapNotes= _mapInfo[2];
		mapProbabilityProbabilityQuestionEvents= _mapInfo[3];
		mapMinNumers = _mapInfo[4];
		mapMaxNumers= _mapInfo[5];
	
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
	//can be given an array
	var randomDungeonType = function(_dungeonTypeS = [dungeonTyps.woods]){
		var dungeonType = findRandomItemInArray(_dungeonTypeS);
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
	var randomContractType = function(_contractTypeS = [contracTyps.boss], _exploreMin = 0.5,_exploreMax = 0.8){
		var contractType = [];
		contractType[0] = findRandomItemInArray(_contractTypeS);
		contractType[1] = 0.5; // not used for now
	
		return contractType;
	}

	#endregion
	
	#region randomMapInfo
	//returns random mapinfo based on the difficulty and contractType
	//_contractType has to be implimnted not sure how yet
	//not sure if need to rework
	var randomMapInfo = function(_difficulty){
		var mapInfo = [];
		switch(_difficulty){
			case enemyDifficulty.easy:
				mapInfo[0] = round(random_range(5, 6)); //mapLength
				mapInfo[1] = 3;							//linesInMap
				mapInfo[2] = [5, 10, 30];				//probabilityTiersMapNotes
				mapInfo[3] = [0, 20, 10];				//probabilityQuestionEvents
				mapInfo[4] = [0, 0, 2, 2];				//minNumers
				mapInfo[5] = [2, 1, 1, 30];				//maxNumers
			break;
			case enemyDifficulty.normal:
				mapInfo[0] = round(random_range(7, 8)); //mapLength
				mapInfo[1] = 4;							//linesInMap
				mapInfo[2] = [15, 10, 20];				//probabilityTiersMapNotes
				mapInfo[3] = [0, 35, 15];				//probabilityQuestionEvents
				mapInfo[4] = [1, 1, 0, 4];				//minNumers
				mapInfo[5] = [1, 2, 2];					//maxNumers
			break;
			case enemyDifficulty.hard:
				mapInfo[0] = round(random_range(9, 10));//mapLength
				mapInfo[1] = 5;							//linesInMap
				mapInfo[2] = [20, 10, 20];				//probabilityTiersMapNotes
				mapInfo[3] = [0, 20, 10];				//probabilityQuestionEvents
				mapInfo[4] = [2, 2, 1, 3];				//minNumers
				mapInfo[5] = [3, 3, 2];					//maxNumers
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
	
	#region contract Gen
	
	//contract 1 
	var difficulty = enemyDifficulty.easy;
	var dungeonType = randomDungeonType();
	var contractType = randomContractType();
	var reward = 100 + round(random_range(20, 70));
	var description = randomDescription(dungeonType, contractType);
	var mapInfo = randomMapInfo(difficulty);
	contracts[0] = new contract(difficulty, dungeonType, contractType, reward, description,mapInfo);
	
	//contract 2
	//should be harder then 1 
	difficulty = enemyDifficulty.easy;
	dungeonType = randomDungeonType();
	contractType = randomContractType();
	reward = 130 + round(random_range(30, 50));
	description = randomDescription( dungeonType, contractType);
	mapInfo = randomMapInfo(difficulty);
	contracts[1] = new contract(enemyDifficulty.easy, dungeonType, contractType, reward, description,mapInfo);
	
	//contract 3
	difficulty = enemyDifficulty.normal;
	dungeonType = randomDungeonType();
	contractType = randomContractType();
	reward = 200 + round(random_range(10, 40));
	description = randomDescription( dungeonType, contractType);
	mapInfo = randomMapInfo(difficulty);
	contracts[2] = new contract(enemyDifficulty.normal, dungeonType, contractType, reward, description,mapInfo);
	
	//contract 4
	//should be harder then 3
	difficulty = enemyDifficulty.normal;
	dungeonType = randomDungeonType();
	contractType = randomContractType();
	reward = 230 + round(random_range(30, 50));
	description = randomDescription( dungeonType, contractType);
	mapInfo = randomMapInfo(difficulty);
	contracts[3] = new contract(enemyDifficulty.normal, dungeonType, contractType, reward, description,mapInfo);
	
	//contract 5
	difficulty = enemyDifficulty.hard;
	dungeonType = randomDungeonType();
	contractType = randomContractType();
	reward = 300 + round(random_range(10, 40));
	description = randomDescription( dungeonType, contractType);
	mapInfo = randomMapInfo(difficulty);
	contracts[4] = new contract(difficulty, dungeonType, contractType, reward, description,mapInfo);
	
	//contract 6
	//should be harder then 5
	difficulty = enemyDifficulty.hard;
	dungeonType = randomDungeonType();
	contractType = randomContractType();
	reward = 330 + round(random_range(30, 50));
	description = randomDescription( dungeonType, contractType);
	mapInfo = randomMapInfo(difficulty);
	contracts[5] = new contract(difficulty, dungeonType, contractType,reward, description,mapInfo);
	#endregion
	
	contracts = array_shuffle(contracts);	
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



