var i = 0, arr_leng = array_length(menuPages);
repeat (arr_leng) {
	ds_grid_destroy(menuPages[i]);
	i++;
}