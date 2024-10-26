extends Node

class_name Stages

@export var col: int
@export var row: int
@export var round1_complete: bool = false
@export var round2_complete: bool = false
@export var round3_complete: bool = false
@export var current_round: int = 1
@export var choice_timer: Timer
@export var game_running: bool = false
@export var grid_scene: PackedScene
@export var player_choice: Tile
@onready var grid_holder: Control = %GridHolder
@export var hazards: Dictionary 
@export var round_end_scene: PackedScene

func _ready() -> void:
	choice_timer = %ChoiceTimer
	choice_timer.timeout.connect(_round_ended)
	
func _process(_delta: float) -> void:
	if game_running:
		var ui: MainUI = get_tree().get_first_node_in_group("ui")
		ui.t_imer_label.text = str(round(choice_timer.time_left))
		ui.round_label.text = "Round: " + str(current_round)

func set_up_grid(list: Array[int] = []):
	
	var grid: Grid = grid_scene.instantiate()
	
	grid_holder.call_deferred("add_child", grid)
	
	grid.generate_grid(col,row,list)
	
	grid_holder.child_entered_tree.connect(_on_grid_holder_child_entered)


func completed_all_rounds() -> bool:
	if not round1_complete and not round2_complete and not round3_complete:
		current_round = 1
	elif round1_complete and not round2_complete and not round3_complete:
		current_round = 2
	elif round1_complete and round2_complete and not round3_complete:
		current_round = 3
	
	if round1_complete and round2_complete and round3_complete:
		return true

	return false

func _on_grid_holder_child_entered(_child):
	
	var confirm: ConfirmReady = get_tree().get_first_node_in_group("confirm ready")
	confirm.visible = true

func generate_hazards():
	completed_all_rounds()
	var grid: Grid = get_tree().get_first_node_in_group("grid")
	GameState.all_affected_tiles.clear()
	GameState.player_choice = null
	var keys: String
	if current_round == 1:
		keys = "round1"
	elif current_round == 2:
		keys = "round2"
	else:
		keys = "round3"
	
	var hazards_copy: Dictionary = hazards.duplicate(true)
	for keys2 in hazards[keys]:
		while hazards_copy[keys][keys2] != 0:
			var ability: Ability
			if keys2 == "cross":
				ability = Cross.new()
			elif keys2 == "star":
				ability = Star.new()
			elif keys2 == "smasher":
				ability = Smash.new()
			add_child(ability)
			
			var random_tile_id = randi_range(0, grid.total_tiles - 1)
			
			var random_tile = grid.get_tile_by_id(random_tile_id)
			if random_tile.current_ability == null and not random_tile.disabled:
				ability.set_up(random_tile)
				random_tile.update_look()
				hazards_copy[keys][keys2] -= 1
	for tile in GameState.all_affected_tiles:
		if tile.exploding and tile.freezing and not tile.cracked:
			tile.cracked = true
		elif tile.exploding and tile.freezing and tile.cracked:
			tile.broken = true
			
	
	check_for_safe_tile()

func check_for_safe_tile():
	var grid: Grid = get_tree().get_first_node_in_group("grid")
	var invalid_map:bool = true
	for tiles:Tile in grid.all_tiles:
		if tiles.is_safe():
			invalid_map = false
			break
	
	if invalid_map:
		print("Map had no safe spots, regenerating")
		for tile in grid.all_tiles:
			tile.reset()
		
		var all_abilities: Array = get_tree().get_nodes_in_group("abilities")
		
		for abi:Node in all_abilities:
			abi.queue_free()
		
		generate_hazards()
	else:
		
		begin_game()
		
func begin_game():
	pass
	
func _round_ended():
	
	game_running = false
	for tile in GameState.all_affected_tiles:
		tile.current_ability = null
		tile.animation_player.play("new_animation")
		await tile.animation_player.animation_finished
		tile.update_look()
	var all_abilities: Array = get_tree().get_nodes_in_group("abilities")
	
	for abi:Node in all_abilities:
		abi.queue_free()
	
	var round_end: RoundEnd = round_end_scene.instantiate()
	add_child(round_end)
	if player_choice == null or not player_choice.is_safe():
		round_end.wrong_tile_chosen()
		for tile:Tile in GameState.all_affected_tiles:
			print(str(tile.is_safe()) + " " +  str(tile.id))
		
		print(" ")
	else:
		
		if current_round == 1:
			round1_complete = true
			
		elif current_round == 2:
			round2_complete = true
		else:
			round3_complete = true
		round_end.round_passed(current_round)
