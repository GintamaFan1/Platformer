extends Ability

class_name Star

func set_up(tile:Tile):
	var grid: Grid = get_tree().get_first_node_in_group("grid")
	
	if tile not in GameState.all_affected_tiles:
		GameState.all_affected_tiles.append(tile)
	tile.exploding = true
	tile.current_ability = self
	
	var directions: Array[int] = [
		-grid.columns - 1,
		-grid.columns + 1,
		grid.columns - 1,
		grid.columns + 1
	]
	 		
	
	for direction in directions:
		var current_id = tile.id
		if tile.col == 0 and tile.row == 0:
			if direction != grid.columns + 1:
				continue
		elif tile.col == 0 and tile.row == grid.rows - 1:
			if direction != -grid.columns + 1:
				continue
		elif tile.col == (grid.columns - 1) and tile.row == 0:
			if direction != grid.columns - 1:
				continue
		elif tile.col == (grid.columns - 1) and tile.row == (grid.rows - 1):
			if direction != -grid.columns - 1:
				continue
		elif tile.col == 0:
			if direction != -grid.columns + 1 and direction != grid.columns + 1:
				continue
		elif tile.col == grid.columns -1:
			if direction != -grid.columns - 1 and direction != grid.columns - 1:
				continue
		
		elif tile.row == 0:
			if direction != grid.columns + 1 and direction != grid.columns - 1:
				continue
		
		elif tile.row == grid.rows - 1:
			if direction != -grid.columns + 1 and direction != -grid.columns - 1:
				continue
			
		
		while true:
			current_id += direction
			var tile2: Tile = grid.get_tile_by_id(current_id)
			if tile2 != null:
				if tile2.disabled:
					continue
				else:
					if tile2  not in GameState.all_affected_tiles:
						GameState.all_affected_tiles.append(tile2)
					tile2.exploding = true
					if tile2.neighbors_id.size() < 4:
						break
			else:
				break
		
	
	
	
	
