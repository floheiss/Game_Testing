event_inherited();

selecedSupport = -1;


function mapNoteFunction(){
	playerGroup = global.playerGroup;
	selecedSupport = playerGroup[0];
	
	skillsOptions = changeDisplayedSkill(selecedSupport);
	
	for(i = 0; i < array_last(skillsOptions);i++){
		mMapDisplayManager.mapOptions[i] = skillsOptions[i]
	}


	for(i = 0; i < array_last(playerGroup);i++){
		if(playerGroup[i] != -1){
			mMapDisplayManager.campfireDisplaySupport[i] = playGroup[i];
		}
		
	}

	
	mMapDisplayManager.activeNote = self;
	mMapDisplayManager.currentMenu = menus.campfire;
	mMapDisplayManager.mapEventImage = mapCampfireImage; //have to make 
	
	mMapDisplayManager.displayEvent();
	displayMapEvent();

}

function changeDisplayedSkill(_unit){
	displayedSkills = [];
	//_unit hold a struct for each campfire skill
		//contains at least
		//title | what it does on click (in scribt) | condition (in scribt)
		//(describtion) 
	
	for(i = 0; i < array_length(_unit.campfireSkills); i ++){
		skill = _unit.campfireSkills[i];
		displayedSkills[i] = new mapOption(skill.title,skill.effect,skill.condition);
	}
	
	return displayedSkills;
}