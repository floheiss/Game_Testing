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
	
	#region startTurn
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
	#endregion
	
	#region wait
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
	#endregion 
	
	#region process
	case phase.process: 
		targeting = false;
		for(var i = 0; i < array_length(units); i ++){
			with(units[i]){
				drawTarget = false;
			}
			
		}
		
		combatPhase = phase.checkFinish;
	break;
	#endregion
	
	#region checkFinish
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
	#endregion
	
	#region end Turn
	case phase.endTurn: 
		combatPhase = phase.startTurn;	
	break;
	#endregion
	
	#region win
	case phase.win: 
		//Loot 
		oGame.transitionRoom(rDungeonMap);
	break;
	#endregion
	
	#region lose
	case phase.lose: 
		//loseScreen 
		oGame.transitionRoom(rDefeat);
	break;
	#endregion
}


