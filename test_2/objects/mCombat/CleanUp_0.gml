if(ds_exists(units, ds_type_list)){
	ds_list_destroy(units);
}

if(ds_exists(targets, ds_type_list)){
	ds_list_destroy(targets);
}

if(ds_exists(selectedTargets, ds_type_list)){
	ds_list_destroy(selectedTargets);
}

if(ds_exists(team0, ds_type_list)){
	ds_list_destroy(team0);
}

if(ds_exists(team1, ds_type_list)){
	ds_list_destroy(team1);
}