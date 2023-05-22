//menuOptions in town and others 
enum menus{
	guild,
	inventory, //can be used in map and town
	merchant, //can be used in map and town
		tavern,
	
	campfire, //for map
	mapEvent, //for map
	
	lootDisplay,//can be used any time loot is diplayed
}
//stats of a button used for all 
enum buttonState{
	active,
	inactive,
	disabled,
	hover
};

//list of all rooms in the game 
enum roomList{
	town,//hub town
	map,//the dungeon map
	battle, //the battle screen
	defeat // the defeat screen
}

#region items 

//list of all items in the game 
//some have multiple tiers (rations, field medical supply)
//also inclues loot drops 
enum itemList{
	bandage,
	healingPotion, //might need rework --> seams to strong with fieldMedicalSupply system
	bloodFlask,
	antiPosion,
	//NEW LINUX
	shovel, //used to remove roadBlocks 
	//you know what (can be used more then once)
	//might also get 2 tiers (basic - advanced)
	lockPickSet, 
	positionOfX,// not sure how many positionOf --> are very simular 

	//used in campfire to heal (no down sides) / (downside based on cost (ratmeat/bread))
	//might add tiers later (item for ratmeat lvl of rations- bread lvl of rations)
	rations,
	//used in campfire --> might add a multiplayer (some classes better)
	//same as rations might add tiers 
	fieldMedicalSupply 
}
#endregion

#region classes 

//rework as most of them are useless/ test only :) 
enum classList{
	bloodMage,
	conquistador, //will stay
	footsoldiar, //will stay
	missonarry, //will stay
	eagleWarrior, //will stay
	jaguarWarrior, //will stay
	hunter, //will stay
	nobal, //will stay
	witchhunter, //will stay
	
	fieldHand, //remove later
	berserker, //remove later
	disownedNobal, //remove later
	butcher, //remove later
	monch, //remove later
	samurai, //remove later
	huntsMan, //remove later
	gunSlinger, //remove later
	peasent, //remove later
}

#endregion

#region contrat, dungeon and map generation stuff

//contracttypes for diffrent contractrs 
enum contracTyps{
	boss,
	collect,
	defeatEnemys,
	exlore
}

//for contracts and dm generation 
//rework as most are unfit
enum dungeonTyps{
	woods,
	gravyard,
	goblinChamp,
	underwater,
	banditChamp, 
	mountain // not sure if in usage 
}

//for contracts and dm generation 
//rework as most are unfit ???
enum enemyTyps{
	goblins,
	bandits,
	occult,
	demons,
	spider,
	beast,
	skeleton,
	ghost,
	mermaid
}

//for contracts and dm generation 
enum enemyDifficulty{
	easy,
	normal,
	hard,
	elite
}

//for map generation
enum noteTypes{
	enemy,
	question,
	elite,
	campfire, // used to heal and manage disgust 
	travalMerchant // can buy items even in run (high prices)
}

//for map generation
//and for random events on a contract
enum events{
	good, //used when generating a question what kind of event it is 
	bad,  //maybe change to just save the event in question not if good/bad/neutral ???
	neutral,
	
	infection, //bad 
	ambush,
	poisionFood,
	
	campfire, //good
	village,
	fallenGood,
	
	merchant //neutral
}
#endregion

#region combat related 

//for mCombat battlephases
enum phase{
	init,
	startTurn,
	wait,
	process,
	checkFinish,
	endTurn,
	win,
	lose
}

//actions in the battlephase
enum actions{
	attack1,
	attack2,
	attack3,
	skill1,
	skill2,
	skill3,
}

//what can be targeted in the battlephase by attacks
enum possibleTargets{
	everybody,
	enemies,
	allies
}
#endregion 

#region char stuffs and buffs

//states for a Unit in battlescreen
enum states{
	IDLE,
	ATTACK1,
	ATTACK2,
	ATTACK3,
	skill1,
	skill2,
	skill3,
	HURT,
	DEATH,
	PROTECT 
}


//for mDot type of dot
enum dotTypes{
	poison,
	bleed
}

//for mBuff what type of buff and debuff
enum buffTypes{
	tempo,
	doge,
	dmgRed,
	
	dmg,
	acc,
	
	reRollDoge,
	reRollCrit,
	reRollAcc
}

//dmgTypes of an attack 
enum dmgType{
	melee,
	ranged,
	magic
}

#endregion


