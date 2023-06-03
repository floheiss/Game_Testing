//is used to display the party infobar at the top of the screen 
//also manages when the icons are clicked and displays the info :)
//not sure if any code is need for updates ??? --> have to look at 
numberOfMembersDisplayed = 0;

function drawPartyInfoBar(){
	if(global.drawPartyInfo){
	for(var i = 0; i < 4; i ++){
		var xCord = room_width/2 - (64*2) + (64 * i);
		var yCord = 0;
		var creation = instance_create_depth(xCord, yCord,0, oPartyInfoIcon);
		
		if(i < global.maxPlayGroupSize){
			var unit = global.playerGroup[i];
			if(unit != -1){
				numberOfMembersDisplayed ++;
				with(creation){
					savedObject = unit;
					changeSprite(xCord, yCord,savedObject.icon,false,0);
					setUseHighlightHoverImage(Basic_HomeLess_Icon,1);
					
					var fun = function(){
							switch(global.room){
								case roomList.town: 
									oMenuScreen.currentDisplayedSupport = savedObject;
									oTown.currentMenu = menus.partyInfo;
									oTown.displayMenuInTown();
								break;
								case roomList.map: 
									with(mMapDisplayManager){
										currentMenu = menus.partyInfo;
										displayEvent();
									}
									mMapDisplayManager.currentDisplayedSupport = savedObject;
								break;
							}
							
						}
					
					MainFunction = fun;
				}
			}else{
				//we do nothing here 
				//becase if there is a slot open we want it "unlocked"
			}
			
		}else{
			with(creation){
				lockWithOutImage(xCord, yCord, Basic_HomeLess_Icon, false, 0);
			}

			
		}
	}
}
}

