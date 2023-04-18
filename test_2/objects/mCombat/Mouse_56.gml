if(targeting){
	if(position_meeting(mouse_x,mouse_y, pUnit)){
		
		var unit = instance_position(mouse_x,mouse_y, pUnit);
		
		switch(attackTargets){
			case possibleTargets.everybody:
			
				switch(actionTaken){
					case actions.attack1: 				
						
						if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) == -1){
							ds_list_add(selectedTargets, unit);
							selectedTeam = selectedUnit.team;  //for now only 2 Teams 0 and 1 
							
								if(ds_list_size(selectedTargets) == selectedUnit.numberTargetAttack1){
									
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
								if(ds_list_size(selectedTargets) == selectedUnit.numberTargetAttack2){
									
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
								if(ds_list_size(selectedTargets) == selectedUnit.numberTargetAttack3){
									
									playUserEvent0120();
									unitAttackUnit(selectedUnit, selectedTargets, actions.attack3);
									
								}
						}else if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) != -1){
							checkIfUnitAlreadySelectedAndDelete(unit);
						}
					break;
				}
		
			break;
		
			case possibleTargets.enemies:
			
				if(selectedUnit.team != unit.team){
					switch(actionTaken){
						case actions.attack1: 				
						
							if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) == -1){
								ds_list_add(selectedTargets,unit);

								if(ds_list_size(selectedTargets) == maxNumberTargets){
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

								if(ds_list_size(selectedTargets) == selectedUnit.numberTargetAttack2){
									
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
								if(ds_list_size(selectedTargets) == selectedUnit.numberTargetAttack3){
									
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
		
			case possibleTargets.allies:
			
				if(selectedUnit.team == unit.team){
					switch(actionTaken){
						case actions.attack1: 				
						
							if(unit != selectedUnit && ds_list_find_index(selectedTargets, unit) == -1){
								ds_list_add(global.selectedTargets,unit);
									if(ds_list_size(global.selectedTargets) == maxNumberTargets){
									
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
									if(ds_list_size(selectedTargets) == selectedUnit.numberTargetAttack2){
									
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
									if(ds_list_size(selectedTargets) == selectedUnit.numberTargetAttack3){
									
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
		}
	}
}