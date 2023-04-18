switch(combatPhase){
	case phase.init: 
		layer_set_visible(targetUI, false);
		instance_deactivate_layer(targetUI);
		layer_set_visible(baseUI, false);
		//team0Array = global.playerGroup;
		//team1Array = global.enemies;
		team0Array = [oSamuraiArcher, oSamuraiCommander];
		//team0Array[0].currentHealth = maxHealth/2;
		
		team1Array = [oSamurai];
		init(team0Array,team1Array);
		
		combatPhase = phase.startTurn;
		
	break;
	
	case phase.startTurn: 
	
		
		
		if(unitsFinished >= ds_list_size(units)){
			turnCounter ++;
			bubble_sort(units);	// have to look at : )
			for (var i = 0; i < ds_list_size(units);i ++){
				with(units[|i]){
					checkEndTurn();
					actionsInTurn = 0;
				}
					
			}
			unitsFinished = 0;
		}
		
		for(var i = 0; i < ds_list_size(units);i ++){
			var inst = units[|i];
			if(inst.actionsInTurn < inst.maxActionsInTurn){
				inst.selected = true;
				selectedUnit = inst;
				break;
			}
		}
	
		if(!allowInput){
			allowInput = true;
			event_user(1);
		}
		combatPhase = phase.wait;
	break;
	
	case phase.wait: 
		if(selectedUnit.actionsInTurn >= selectedUnit.maxActionsInTurn){
			selectedUnit.selected = false;
			unitsFinished ++;
			combatPhase = phase.process;
			
			event_user(0);
			layer_set_visible(targetUI, false);
			instance_deactivate_layer(targetUI);
			layer_set_visible(baseUI, false);
			instance_deactivate_layer(baseUI);
		}
	break;
	
	case phase.process: 
		targeting = false;
		for(var i = 0; i < ds_list_size(units); i ++){
			with(units[|i]){
				drawTarget = false;
			}
			
		}
		
		combatPhase = phase.checkFinish;
	break;
	
	case phase.checkFinish: 
		if(ds_list_size(team0) <=  0){
			combatPhase = phase.lose;
			break;
		} else if(ds_list_size(team1) <=  0){
			combatPhase = phase.win;
			break;
		} 
		combatPhase = phase.endTurn;
		prozessFinished = false;
	break;
	
	case phase.endTurn: 
		ds_list_clear(targets);
		combatPhase = phase.startTurn;
		
	break;
	
	case phase.win: 
		//Loot 
		room_goto(rDungeonMap);
	break;
	
	case phase.lose: 
		//loseScreen 
		room_goto(rDefeat);
	break;	
}


