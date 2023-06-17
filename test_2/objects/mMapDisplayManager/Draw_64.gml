if(mapEventImage != -1){
	//Have to make new images (700 / 600) for Menu_Background_Inventory
	//and mapEventImage should have 600 / 200
	//with space inbetwean
	//text options background --> 600 /50
	draw_sprite(mapEventBackGround,0,1280/2,720/2 + 50);
	draw_sprite(mapEventImage,0, 1280/2,720/2 - 80);
	draw_text(350, 360, autoLineBreaker(discribtionText, (sprite_get_width(sprite_index) / 2) - 20, 30));
}
if(currentMenu == menus.inventory){
	draw_sprite(Menu_Background_Inventory,0,x,y);
}