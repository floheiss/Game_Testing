event_inherited();

#region  "AI" (What attack to use)
if(global.room == roomList.battle){
	var attackIng = (mCombat.selectedUnit == id) ? true : false;
	
	if(attackIng){
		var usedAttackMethode = -1;
		var usedAttackStruct = -1;

		//selects a random attack	
		#region select attack
	
		var chancesPerAttack = [];
		if(array_length(chancesOfAttacks) == 0){
			for(i = 0; i < array_length(chancesOfAttacks); i ++){
				chancesPerAttack[i] = floor((99 / array_length(chancesOfAttacks)) * (i + 1));  
			}
		}else{
			
			#region chance the array to chances 
			for(var i = 0; i < array_length(chancesPerAttack); i ++){
				if(i == 0){
					chancesPerAttack[i] = attackChancesSingle[i];
				}else{
					chancesPerAttack[i] = attackChancesSingle[i] + chancesPerAttack[i - 1];
				}
			}
			
			#endregion
				
		}
		
		var number = chanceFrom100();
		var attackNumber = 1;
		for(var i = 0; i < array_length(chancesPerAttack); i ++){
			if(number < chancesPerAttack[i]){
				attackNumber = i + 1;
				break;
			}
		}
		attackNumber = (attackNumber > array_length(chancesPerAttack))? 1: attackNumber;
	
		switch(attackNumber){
			case 1:
				usedAttackMethode = attack1;
				usedAttackStruct = attack1Stru;
			break;
			case 2:
				usedAttackMethode = attack2;
				usedAttackStruct = attack2Stru;
			break;
			case 3:
				usedAttackMethode = attack3;
				usedAttackStruct = attack3Stru;
			break;
			case 4:
				usedAttackMethode = attack4;
				usedAttackStruct = attack4Stru;
			break;
			case 5:
				usedAttackMethode = attack5;
				usedAttackStruct = attack5Stru;
			break;				
		}

		#endregion
	
		//usedAttackNumber is now the number of the attack
		//usedAttackStruct is now the struct of the attack
	
		//now selects the target/s that will be attacked
		#region targetSelection
		var targets = [];
		var numberTarget = usedAttackStruct.targetNumber;
		if(attackPrio == -1){
			for(i = 0; i < numberTarget; i ++){
				targets[i] = findRandomItemInArray(mCombat.team0);
			}
	
		} /* else{ //will be added not sure ?????
			switch(attackPrio){
				case attackPrios.lowest:
				
				break;
			}
		}*/
	
		#endregion
	
		if(!attacked){
			method_call(usedAttackMethode,[targets]);
			attacked = true;
		}
		
		/*
		with(oGame){
			event_user(0);
		}
		with(mCombat){
			event_user(2);
			event_user(1);
		}
		with(oGame){
			event_user(0);
		}*/
	}
}
#endregion