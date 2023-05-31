switch(combatPhase){

	#region init
	
	case phase.init: 
		layer_set_visible(targetUI, false);
		instance_deactivate_layer(targetUI);
		layer_set_visible(baseUI, true);
		
		var team0Array = [];
		var team1Array = [];
		
		for(var i = 0; i < array_length(global.playerGroup); i ++){
			if(global.playerGroup[i] != -1){
				team0Array[i] = global.playerGroup[i];
			}
		}
	
		for(var i = 0; i < array_length(global.enemies); i ++){
			team1Array[i] = global.enemies[i];
		}
		
		init(team0Array, team1Array);
		
		drawRdy = true;
		
		combatPhase = phase.startTurn;
		bubble_sort(units);
	break;
	
	#endregion
	
	case phase.startTurn: 
		 // have to look at : )
		if(unitsFinished >= array_length(units)){
			bubble_sort(units);
			turnCounter ++;
			for (var i = 0; i < array_length(units);i ++){
				with(units[i]){
					checkEndTurn();
					actionsInTurn = 0;
				}
			}
			unitsFinished = 0;
		}
		
		for(var i = 0; i < array_length(units);i ++){
			var inst = units[i];
			if(inst.actionsInTurn < inst.maxActionsInTurn){
				inst.selected = true;
				selectedUnit = inst;
				break;
			}
		}
		
		combatPhase = phase.wait;
		
	break;
	
	case phase.wait: 
		targeting = true;
		if(selectedUnit.actionsInTurn >= selectedUnit.maxActionsInTurn){
			selectedUnit.selected = false;
			unitsFinished ++;
			combatPhase = phase.process;
			
			layer_set_visible(targetUI, false);
			instance_deactivate_layer(targetUI);
		}
		
	break;
	
	case phase.process: 
		targeting = false;
		for(var i = 0; i < array_length(units); i ++){
			with(units[i]){
				drawTarget = false;
			}
			
		}
		
		combatPhase = phase.checkFinish;
	break;
	
	case phase.checkFinish: 
		if(array_length(team0) <=  0){
			combatPhase = phase.lose;
			break;
		} else if(array_length(team1) <=  0){
			combatPhase = phase.win;
			break;
		} 
		combatPhase = phase.endTurn;
		prozessFinished = false;
	break;
	
	case phase.endTurn: 
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


