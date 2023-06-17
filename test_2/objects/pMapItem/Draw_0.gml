event_inherited();
draw_text(x,y,"col self: " +  string(columnSelf));

for(var i = 0; i < array_length(preNotes); i ++){
	draw_text(x,y + 10*1+i, "pn: " + string(preNotes[i].positionInList));
}

draw_text(x,y + 30, "pos: " + string(positionInList));