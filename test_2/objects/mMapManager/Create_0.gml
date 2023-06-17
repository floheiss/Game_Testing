activeColumn = (global.map != false) ? global.map.activeColumn : 0; 
mapDisplayed = (global.map != false) ? true : false;

function findMapItem(){
	var list = [];
	for(var i = 0; i < instance_number(pMapItem);i ++){
		var instance = instance_find(pMapItem, i);
		list[i] = instance;
	}
	return list;
}

objects = [];

function changeActiveColumn(_useNote){
	//for now only ++ as you can never go back in the map lul
	activeColumn ++;
	global.map.activeColumn = activeColumn;
	global.map.pathInMap[array_length(global.map.pathInMap)] = _useNote;
	
}