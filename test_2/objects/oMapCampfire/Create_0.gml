event_inherited();

selecedSupport = -1;

targetingForSkill = false;

function mapNoteFunction(){
	
	for(i = 0; i < array_length(global.playerGroup); i ++){
		playerGroup[i] = global.playerGroup[i];
	}

	
	for(i = 0; i < array_last(playerGroup);i++){
		if(playerGroup[i] != -1){
			mMapDisplayManager.campfireDisplaySupport = []; 
			mMapDisplayManager.campfireDisplaySupport[i] = playerGroup[i];
		}
		
	}

	
	mMapDisplayManager.activeNote = self;
	mMapDisplayManager.currentMenu = menus.campfire;
	mMapDisplayManager.mapEventImage = mapCampfireImage; //have to make not sure as always the same 
	
	mMapDisplayManager.displayEvent();
	displayMapEvent();

}


//is used to change/update the current Skill option displayed in the Menu 
//is given a support
function updateSkillOptions(_unit){
	displayedSkills = [];
	//_unit hold a struct for each campfire skill
		//contains at least
		//title | what it does on click (in scribt) | condition (in scribt)
		//(describtion) 
	//Skill and CampfireSkill are the same thing save the info 
	for(i = 0; i < array_length(_unit.campfireSkills); i ++){
		skill = _unit.campfireSkills[i];
		displayedSkills[i] = new mapOption(skill.title,skill.onClick,skill.condition);
	}
	
	for(i = 0; i < array_last(displayedSkills);i++){
		mMapDisplayManager.mapOptions[i] = skillsOptions[i];
	}
}


//is use the change the seleced Support 
function updateSelecedSupport(_mapOption){
	if(selecedSupport != -1){
		selecedSupport[0].seleced = false;
	}
	selecedSupport = [_mapOption, _mapOption.savedObject];
	_mapOption.seleced = true;
	updateSkillOptions(selecedSupport[1]);
	
}