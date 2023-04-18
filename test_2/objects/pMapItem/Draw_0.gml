draw_self();
draw_text(x,y, "p: " + string(positionInList));
draw_text(x,y + 16, "pN:");
for(i = 0; i < array_length(preNotes); i ++){
	draw_text(x + 20 + 16* i,y + 16 ,preNotes[i]);
} 


if(global.map.objectAtNotes[positionInList].subImage == 1){
	image_index = 1;
}
