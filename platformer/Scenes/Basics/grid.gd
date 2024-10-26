extends GridContainer
class_name Grid

@export var tile_scene: PackedScene 
var all_tiles: Array[Tile] = []
var total_tiles: int 
var rows: int

func generate_grid(col:int, row: int, list:Array[int] = []):
	columns = col
	rows = row
	print("generating grid")
	
	total_tiles = col * row
	
	var tally: int = 0
	
	while tally != total_tiles:
		
		var tile: Tile = tile_scene.instantiate()
		
		tile.id = tally
		
		if tile.id in list:
			tile.disabled = true
		
		tile.col = tally % col
		tile.row = tally / col
		
		get_cross_neighbors(tile)
		call_deferred("add_child", tile)
		all_tiles.append(tile)
		
		tally += 1
		
func get_diagonal_neighbors(tile:Tile):
	var start: int = tile.id
	var top_left: int = start - (columns - 1)
	var top_right: int = start - (columns + 1)
	var bottom_left: int = start + (columns - 1)
	var bottom_right: int = start + (columns + 1)
	var neighbors: Array[int] = [top_left, top_right, bottom_left, bottom_right]
	
	for neigh in neighbors:
		if neigh < 0 or neigh > total_tiles - 1:
			continue
		
		
		
	
func get_cross_neighbors(tile: Tile):
	var start: int = tile.id
	var left:int = start - 1
	var right:int = start + 1
	var up:int = start - columns
	var down:int = start + columns
	var neighbors: Array[int] = [left, right, up, down]
	
	for neigh in neighbors:
		if neigh < 0 or neigh > total_tiles - 1:
			continue
		
		if tile.col == 0:
			if neigh == left:
				continue
		if tile.col == columns - 1:
			if neigh == right:
				continue
		
		tile.neighbors_id.append((neigh))

func get_tile_by_id(id: int) -> Tile:
	for tile:Tile in all_tiles:
		if tile.id == id:
			return tile
	return null

func randomly_crack(num:int):
	pass
	
func randomly_break(num:int):
	pass

func porpouseful_break(list: Array[Tile]):
	pass
