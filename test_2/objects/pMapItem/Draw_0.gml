event_inherited();
draw_text(x,y, string(positionInList));
for(var i = 0; i < array_length(preNotes); i ++){
	draw_text(x,y + 12*(i + 1),"pn[" + string(i)+ "]: "+ string(preNotes[i].positionInList));

}
