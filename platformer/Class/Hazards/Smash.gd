extends Ability


class_name Smash

func set_up(tile:Tile):
	var grid: Grid = get_tree().get_first_node_in_group("grid")
	
	if not tile.cracked:
		tile.cracked = true
	else:
		tile.broken = true
	if tile not in GameState.all_affected_tiles:
		GameState.all_affected_tiles.append(tile)
	
	tile.current_ability = self
	
	
	for id in tile.neighbors_id:
		var tile2: Tile = grid.get_tile_by_id(id)
		if tile2 != null and not tile2.disabled:
			for id2 in tile2.neighbors_id:
				var tile3: Tile = grid.get_tile_by_id(id2)
				if tile3 != null and not tile3.disabled:
					if tile3 not in GameState.all_affected_tiles:
						GameState.all_affected_tiles.append(tile3)
					if not tile3.cracked:
						tile3.cracked = true
					else:
						tile3.broken = true
			if tile2 not in GameState.all_affected_tiles:
				GameState.all_affected_tiles.append(tile2)
			if not tile2.cracked:
				tile2.cracked = true
			else:
				tile2.broken = true
				
			
				
			
		
		
	
