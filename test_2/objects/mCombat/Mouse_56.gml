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
		
		#region checkValdiTarget 
		
		//checks if a given unit is a valid target for the attack 
		//if it is ALREADY SELECTED it retuns -1 
		//else it will return true if valid 
		//or false if NOT vaild 
		var checkValidTarget = function(_value){
				var valid = false;
				for(var i = 0; i < array_length(selectedTargets); i ++){
					if(selectedTargets[i].id == _value.id){
						valid= -1;
						break;
					} 
				}
				
				if(!valid){
					switch(attackTargets){
						case possibleTargets.enemies:
							valid = (_value.team != selectedUnit.team)? true: false;
						break;
						case possibleTargets.allies: 		
							valid = (_value.team == selectedUnit.team)? true: false;
						break;
						case possibleTargets.everybody: 		
							valid = true;	
						break;
					}
				}
				
				return valid;
			}
		#endregion
				
		if(checkValidTarget(unit) == -1){
			var _con = function(_value){
				return _value.id == unit.id;
			}
			var index = array_find_index(selectedTargets, _con);
			array_delete(selectedTargets, index, 1);
			show_debug_message(string(unit.id) + " was already selected and has been removed");
		}else if(checkValidTarget(unit)){
			selectedTargets[array_length(selectedTargets)] = unit;
			show_debug_message(string(unit.id) + " was a vaild target and has been added");
		}else{
				show_debug_message(string(unit.id) + " was NOT a  vaild target and has been added")
		}
		if(array_length(selectedTargets) == maxNumberTargets){							
			unitAttackUnit(selectedUnit, selectedTargets, actionTaken);
			playUserEvent0120();
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
