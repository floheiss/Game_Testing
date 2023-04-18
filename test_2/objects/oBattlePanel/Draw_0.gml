draw_self();

//if hoverdAttack is set to an attack it displaies the title and the describtion of the attack
if(hoverdAttack != false){
	unit = mCombat.selectedUnit;
	switch (hoverdAttack){
		case actions.attack1:
			draw_text(x,y,"Test 1");
		break;
		
		case actions.attack2:
			draw_text(x,y,"Test 2");
		break;
		
		case actions.attack3:
			draw_text(x,y,"Test 3");
		break;
	}
}