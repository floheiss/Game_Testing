//menuOptions in town and others 
enum menus{
	guild,
	inventory,
	mercant, //can be used in map and in town
	tavern,
	
	campfire, //for map
	question //for map
	
}
//stats of a button used for all 
enum buttonState{
	active,
	inactive,
	disabled,
	hover
};

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

#region contrat, dungeon and map generation stuff

//contracttypes for diffrent contractrs 
enum contracTyps{
	boss,
	collect,
	defeatEnemys,
	exlore
}

//for contracts and dm generation 
enum dungeonTyps{
	woods,
	gravyard,
	goblinChamp,
	underwater,
	banditChamp, 
	mountain // not sure if in usage 
}

//for contracts and dm generation 
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
	travalMerchant, // can buy items even in run (high prices)
	roadBlock //(can be played anywhere or form question) (not sure if only question)
	
}

//for map generation
enum eventKinds{
	good,
	bad,
	neutral
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
	useBandage
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


