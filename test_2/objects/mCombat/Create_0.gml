randomize(); 

combatPhase = phase.init;
unitsFinished = 0;
prozessFinished = false;

playGroup = [];
enemyGroup = [];

actionTaken = actions.attack1;
attackTargets = possibleTargets.everybody;
maxNumberTargets = 0;
drawRdy = false;

selectedUnit = 0; 
units = [];

selectedTargets = []; 
targets = []; 
targeting = false;

team0 = [];
team1 = [];

turnCounter = 1;

baseUI = layer_get_id("BaseUI");
targetUI = layer_get_id("TargetingUI");

function init(team0Array, team1Array){
	var sizeTeam0 = array_length(team0Array);
	var sizeTeam1 = array_length(team1Array);
	
	#region find position function
	
	//finds the position in the display for given array 
	//is used for teams in mCombat
	var findPosition = function(_sizeOfTeam, _team){
		var positionsX = [];
		var positionsY = [];
	
		if(_team == 0){
			switch(_sizeOfTeam){
				case 1: 
					positionsX[0] = 224; 
					positionsY[0] = 224;
				break;
				case 2: 
					positionsX[0] = 224; 
					positionsY[0] = 96;
					positionsX[1] = 224; 
					positionsY[1] = 320;
				break;
				case 3: 
					positionsX[0] = 128; 
					positionsY[0] = 224;
					positionsX[1] = 352; 
					positionsY[1] = 96;
					positionsX[2] = 352; 
					positionsY[2] = 320;
				break;
				case 4: 
					positionsX[0] = 96; 
					positionsY[0] = 96;
					positionsX[1] = 352; 
					positionsY[1] = 96;
					positionsX[2] = 96;
					positionsY[2] = 320;
					positionsX[3] = 352;
					positionsY[3] = 320;
				break;
			}
		}else if(_team == 1){
			switch(_sizeOfTeam){
				case 1: 
					positionsX[0] = 928; 
					positionsY[0] = 224;
				break;
				case 2: 
					positionsX[0] = 928; 
					positionsY[0] = 96;
					positionsX[1] = 928; 
					positionsY[1] = 320;
				break;
				case 3: 
					positionsX[0] = 1024; 
					positionsY[0] = 224;
					positionsX[1] = 800; 
					positionsY[1] = 96;
					positionsX[2] = 800; 
					positionsY[2] = 320;
				break;
				case 4: 
					positionsX[0] = 1024; 
					positionsY[0] = 96;
					positionsX[1] = 800; 
					positionsY[1] = 96;
					positionsX[2] = 800;
					positionsY[2] = 320;
					positionsX[3] = 1024;
					positionsY[3] = 320;
				break;
				case 5: 
					positionsX[0] = 1024; 
					positionsY[0] = 32;
					positionsX[1] = 800; 
					positionsY[1] = 96;
					positionsX[2] = 800;
					positionsY[2] = 320;
					positionsX[3] = 1024;
					positionsY[3] = 192;
					positionsX[4] = 1024;
					positionsY[4] = 352;
				break;
			}
		
		}
		var positonXY = [positionsX, positionsY];
		positonXY[0] = positionsX
		return positonXY;
	}
	
	#endregion
	
	//team 0 
	#region find positions for team0
	var positonsXYTeam0 = findPosition(sizeTeam0, 0);

	var positonsXTeam0 = [];
	var positonsYTeam0 = [];
	for(var i = 0; i < sizeTeam0; i ++){
		positonsXTeam0[i] = positonsXYTeam0[0][i];
		positonsYTeam0[i] = positonsXYTeam0[1][i];
	}	
	
	#endregion
	
	for(var i = 0; i < sizeTeam0; i ++){
		var unit = team0Array[i];
		unit.x = positonsXTeam0[i];
		unit.y = positonsYTeam0[i];
		unit.position = i;
		team0[i] = unit;
		units[i] = unit; 
	}
	
	
	//team 1 
	#region find positions for team0
	
	var positonsXYTeam1 = findPosition(sizeTeam1, 1);
	var positonsXTeam1 = [];
	var positonsYTeam1 = [];
	for(var i = 0; i < sizeTeam1; i ++){
		positonsXTeam1[i] = positonsXYTeam1[0][i];
		positonsYTeam1[i] = positonsXYTeam1[1][i];
	}
	
	#endregion
	
	for(var i = 0; i < sizeTeam1;i ++){
		var unit = team1Array[i];
		unit.x = positonsXTeam1[i];
		unit.y = positonsYTeam1[i];
		unit.position = i;
		unit.team = 1;
		team1[i] = unit;
		units[i + sizeTeam0]= unit; 
	}
	
}





