if(bg != false){
	draw_sprite(bg, bgSubimage, x,y);
}

xPos = x - 450;
yPos = y + 100;

if(!currentDisplayedContrat &&
	!currentDisplayedItem &&
	!currentDisplayedSupport){
	draw_text(xPos,yPos, welcomeText);
}

if(currentDisplayedContrat != false && oTown.currentMenu == menus.guild){
	draw_text(xPos,yPos, currentDisplayedContrat.descriptionTitle);
	draw_text(xPos ,yPos + 20, currentDisplayedContrat.descriptionMission);
	draw_text(xPos ,yPos + 20 + 20, "I will even give you something extra " + string(currentDisplayedContrat.reward) + "g");
}

if(currentDisplayedItem != false && oTown.currentMenu == menus.merchant){
	draw_text(xPos,yPos, currentDisplayedItem.name);
	draw_text(xPos ,yPos + 20, currentDisplayedItem.merchantText);
	draw_text(xPos ,yPos + 20 + 20, "It woll only cost you " + string(currentDisplayedItem.cost) + " gold");
}

if(currentDisplayedSupport!= false && oTown.currentMenu == menus.tavern){
	draw_text(xPos,yPos, currentDisplayedSupport.hoverText);
	draw_text(xPos ,yPos + 20, "You can hire him/her for " + string(currentDisplayedSupport.cost) + " gold");
}

