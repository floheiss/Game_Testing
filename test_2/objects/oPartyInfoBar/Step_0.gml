var numberInParty = 0;
for(var i = 0; i < global.maxPlayGroupSize; i ++){
	if(global.playerGroup[i] != -1){
		numberInParty ++;
	} 
}

if(numberInParty > numberOfMembersDisplayed){
	drawPartyInfoBar();
}