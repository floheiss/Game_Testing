randomize(); 

combatPhase = phase.init;
unitsFinished = 0;
prozessFinished = false;
allowInput = false;

playGroup = [];
enemyGroup = [];

actionTaken = actions.attack1;
attackTargets = possibleTargets.everybody;
maxNumberTargets = 0;

selectedUnit = ds_list_create(); 
units = ds_list_create();

selectedTargets = ds_list_create(); 
targets = ds_list_create(); 
targeting = false;

team0 = ds_list_create();
team1 = ds_list_create();

turnCounter = 1;

baseUI = layer_get_id("BaseUI");
targetUI = layer_get_id("TargetingUI");


function init(team0Array, team1Array){
	cSpawerTeam0 = ds_list_create();
	cSpawerTeam1 = ds_list_create();
	var sizeTeam0 = array_length(team0Array);
	var sizeTeam1 = array_length(team1Array);
	

	
	for(var i = 0; i < instance_number(cSpawner);i ++){
		instance = instance_find(cSpawner, i);
		if(i < array_length(team0Array)){
			ds_list_add(cSpawerTeam0, instance);
		}else if(i < (sizeTeam0 + sizeTeam1)){
			ds_list_add(cSpawerTeam1, instance);
		}
	}
	//team 0 
	var positonsXYTeam0 = findPosition(sizeTeam0, 0);

	var positonsXTeam0 = [];
	var positonsYTeam0 = [];
	for(var i = 0; i < sizeTeam0; i ++){
		positonsXTeam0[i] = positonsXYTeam0[0][i];
		positonsYTeam0[i] = positonsXYTeam0[1][i];
	}	
	for(var i = 0; i < sizeTeam0;i ++){
		switch(sizeTeam0){
			case 1:
				spawer = cSpawerTeam0[|i];
				var unit = instance_create_depth(positonsXTeam0[i], positonsYTeam0[i], 0 , team0Array[i]);
				unit.position = i;
				ds_list_add(team0, unit)
				ds_list_add(units, unit); 
			break;
			case 2: 
				spawer = cSpawerTeam0[|i];
				var unit = instance_create_depth(positonsXTeam0[i], positonsYTeam0[i], 0 , team0Array[i]);
				unit.position = i;
				ds_list_add(team0, unit)
				ds_list_add(units, unit); 
			break;
			case 3: 
				spawer = cSpawerTeam0[|i];
				var unit = instance_create_depth(positonsXTeam0[i], positonsYTeam0[i], 0 , team0Array[i]);
				unit.position = i;
				ds_list_add(team0, unit)
				ds_list_add(units, unit); 
			break;
			case 4: 
				spawer = cSpawerTeam0[|i];
				var unit = instance_create_depth(positonsXTeam0[i], positonsYTeam0[i], 0 , team0Array[i]);
				unit.position = i;
				ds_list_add(team0, unit)
				ds_list_add(units, unit); 
			break;
		}
	}
	
	
	//team 1 
	var positonsXYTeam1 = findPosition(sizeTeam1, 1);
	var positonsXTeam1 = [];
	var positonsYTeam1 = [];
	for(var i = 0; i < sizeTeam1; i ++){
		positonsXTeam1[i] = positonsXYTeam1[0][i];
		positonsYTeam1[i] = positonsXYTeam1[1][i];
	}
	for(var i = 0; i < sizeTeam1;i ++){
		switch(sizeTeam1){
			case 1:
				spawer = cSpawerTeam1[|i];
				var unit = instance_create_depth(positonsXTeam1[i], positonsYTeam1[i], 0 , team1Array[i]);
				unit.team = 1;
				unit.position = i;
				ds_list_add(team1, unit)
				ds_list_add(units, unit); 
			break;
			case 2: 
				spawer = cSpawerTeam1[|i];
				var unit = instance_create_depth(positonsXTeam1[i], positonsYTeam1[i], 0 , team1Array[i]);
				unit.team = 1;
				unit.position = i;
				ds_list_add(team1, unit)
				ds_list_add(units, unit); 
			break;
			case 3: 
				spawer = cSpawerTeam1[|i];
				var unit = instance_create_depth(positonsXTeam1[i], positonsYTeam1[i], 0 , team1Array[i]);
				unit.team = 1;
				unit.position = i;
				ds_list_add(team1, unit)
				ds_list_add(units, unit); 
			break;
			case 4: 
				spawer = cSpawerTeam1[|i];
				var unit = instance_create_depth(positonsXTeam1[i], positonsYTeam1[i], 0 , team1Array[i]);
				unit.team = 1;
				unit.position = i;
				ds_list_add(team1, unit)
				ds_list_add(units, unit); 
			break;
			case 5: 
				spawer = cSpawerTeam1[|i];
				var unit = instance_create_depth(positonsXTeam1[i], positonsYTeam1[i], 0 , team1Array[i]);
				unit.team = 1;
				unit.position = i;
				ds_list_add(team1, unit)
				ds_list_add(units, unit); 
			break;
		}
	}
	
}



























































































