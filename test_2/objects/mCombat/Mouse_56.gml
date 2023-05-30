if(targeting && global.allowInput){
	if(position_meeting(MOUSEGUI_X,MOUSEGUI_Y, pUnit)){
		var unit = instance_position(MOUSEGUI_X,MOUSEGUI_Y, pUnit);
		#region unitAttackUnit
		
		var unitAttackUnit = function(attacker, target, attack){
			switch(attack){
				case actions.attack1: 
					with(attacker){
						attacker.attack1(target);
					}
				break;
				case actions.attack2: 
					with(attacker){
						attacker.attack2(target);
					}
				break;
				case actions.attack3: 
					with(attacker){
						attacker.attack3(target);
					}		
			}
		}
		
		#endregion
		
		#region playUserEvents
		
		var playUserEvent0120 = function(){
			with(oGame){
				event_user(0);
			}
			event_user(1);
			event_user(2);
			
			with(oGame){
				event_user(0);
			}
		}
		
		
		#endregion
		
		
		switch(attackTargets){
			#region everybody
			case possibleTargets.everybody:
				switch(actionTaken){
					case actions.attack1: 				
						
						if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) == -1){
							ds_list_add(selectedTargets, unit);
							selectedTeam = selectedUnit.team;  //for now only 2 Teams 0 and 1 
							
								if(array_length(selectedTargets) == selectedUnit.numberTargetAttack1){
									
									playUserEvent0120();
									unitAttackUnit(selectedUnit, selectedTargets, actions.attack1);
									
								}
						}else if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) != -1){
								checkIfUnitAlreadySelectedAndDelete(unit);
							}		
					
					break;
			
					case actions.attack2: 
						
						if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) == -1){
							ds_list_add(selectedTargets,unit);
								if(array_length(selectedTargets) == selectedUnit.numberTargetAttack2){
									
									playUserEvent0120();
									unitAttackUnit(selectedUnit, global.selectedTargets, actions.attack2);
									
								}
						}else if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) != -1){
							checkIfUnitAlreadySelectedAndDelete(unit);
						}
					break;
					
					case actions.attack3: 
						
						if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) == -1){
							ds_list_add(selectedTargets,unit);
								if(array_length(selectedTargets) == selectedUnit.numberTargetAttack3){
									
									playUserEvent0120();
									unitAttackUnit(selectedUnit, selectedTargets, actions.attack3);
									
								}
						}else if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) != -1){
							checkIfUnitAlreadySelectedAndDelete(unit);
						}
					break;
				}
			
			break;
			
			#endregion
			
			
			#region enemies
			
			case possibleTargets.enemies:
				if(selectedUnit.team != unit.team){
					switch(actionTaken){
						case actions.attack1: 				
							var alreadySelected = false;
							for(var i = 0; i < array_length(selectedTargets); i ++){
								if(selectedTargets[i].id == unit.id){
									alreadySelected = true;
									break;
								}
							}
							if(unit != selectedUnit && !alreadySelected){
								selectedTargets[array_length(selectedTargets)] = unit;
								
								if(array_length(selectedTargets) == maxNumberTargets){
									
									unitAttackUnit(selectedUnit, selectedTargets, actions.attack1);
									playUserEvent0120();
								}
							}else if(unit != selectedUnit && alreadySelected){
								checkIfUnitAlreadySelectedAndDelete(unit);
							}
							
							
						break;
			
						case actions.attack2: 
							
							
							if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) == -1){
								ds_list_add(selectedTargets,unit);

								if(array_length(selectedTargets) == selectedUnit.numberTargetAttack2){
									
									playUserEvent0120();
									unitAttackUnit(selectedUnit, selectedTargets, actions.attack2);
									
								}
							}else if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) != -1){
								checkIfUnitAlreadySelectedAndDelete(unit);
							}
							
						
						break;
						case actions.attack3: 
						
							if(unit != selectedUnit&& ds_list_find_index(selectedTargets, unit) == -1){
								ds_list_add(selectedTargets,unit);
								if(array_length(selectedTargets) == selectedUnit.numberTargetAttack3){
									
									playUserEvent0120();
									unitAttackUnit(selectedUnit, selectedTargets, actions.attack3);
									
								}
							}else if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) != -1){
								checkIfUnitAlreadySelectedAndDelete(unit);
							}
							
						break;
					}
				}
		
			break;
			#endregion
			
			#region allies
			
			case possibleTargets.allies:
			
				if(selectedUnit.team == unit.team){
					switch(actionTaken){
						case actions.attack1: 				
						
							if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) == -1){
								ds_list_add(global.selectedTargets,unit);
									if(array_length(global.selectedTargets) == maxNumberTargets){
									
										playUserEvent0120();
										unitAttackUnit(selectedUnit, global.selectedTargets, actions.attack1);
									
									}
							}else if(unit != selectedUnit && ds_list_find_index(global.selectedTargets, unit) != -1){
								checkIfUnitAlreadySelectedAndDelete(unit);
							}
							
							
						break;
			
						case actions.attack2: 		
							if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) == -1){
								ds_list_add(selectedTargets,unit);
									if(array_length(selectedTargets) == selectedUnit.numberTargetAttack2){
									
										playUserEvent0120();
										unitAttackUnit(selectedUnit, selectedTargets, actions.attack2);
									
									}
							}else if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) != -1){
								checkIfUnitAlreadySelectedAndDelete(unit);
							}
							
							
						break;
						
						case actions.attack3: 
						
							if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) == -1){
								ds_list_add(selectedTargets,unit);
									if(array_length(selectedTargets) == selectedUnit.numberTargetAttack3){
									
										playUserEvent0120();
										unitAttackUnit(selectedUnit, selectedTargets, actions.attack3);
									
									}
							}else if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) != -1){
								checkIfUnitAlreadySelectedAndDelete(unit);
							}
							
						break;
					}
				}
		
			break;
			
			#endregion
		
		}
		
		#region reset all	
		
		targets = []; 
		selectedTargets = []; 
		actionTaken = actions.attack1;
		attackTargets = possibleTargets.everybody;
		maxNumberTargets = 0;
		
		#endregion
		
	}
}