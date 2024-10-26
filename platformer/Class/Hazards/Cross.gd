extends Ability

class_name Cross

func set_up(tile:Tile):
	var grid: Grid = get_tree().get_first_node_in_group("grid")

	if tile not in GameState.all_affected_tiles:
		GameState.all_affected_tiles.append(tile)
	tile.freezing = true
	tile.current_ability = self
	
	
	for tile2 in grid.all_tiles:
		if tile2.col == tile.col or tile2.row == tile.row:
			if tile2.disabled == false:
				tile2.freezing = true
				if tile2 not in GameState.all_affected_tiles:
					GameState.all_affected_tiles.append(tile2)
		
	
	
	
	
	
	
	
	
			
		
		
	
