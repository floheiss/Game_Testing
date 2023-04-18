if(bg != false){
	draw_sprite(bg, bgSubimage, x,y);
}

if(!currentDisplayedContrat &&
	!currentDisplayedItem){
	draw_text(x + 70, y + 290, welcomeText);
}


if(currentDisplayedContrat != false && oTown.currentMenu == menus.guild){
	draw_text(x + 70, y + 290, currentDisplayedContrat.descriptionTitle);
	draw_text(x + 70 , y + 290 + 20, currentDisplayedContrat.descriptionMission);
	draw_text(x + 70 , y + 290 + 20 + 20, "I will even give you something extra " + string(currentDisplayedContrat.reward) + "g");
}

if(currentDisplayedItem != false && oTown.currentMenu == menus.merchant){
	draw_text(x + 70, y + 290, currentDisplayedItem.name);
	draw_text(x + 70 , y + 290 + 20, currentDisplayedItem.merchantText);
	draw_text(x + 70 , y + 290 + 20 + 20, "It woll only cost you " + string(currentDisplayedItem.cost) + "g");
}
