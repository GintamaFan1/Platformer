extends Button

class_name Tile

var exploding: bool = false
var freezing: bool = false
var cracked: bool = false
var broken: bool = false
var id: int
var neighbors_id: Array [int] = []
var col: int
var row: int
var current_ability: Ability
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func is_safe() -> bool:
	
	if not broken and not disabled:
		if not freezing and not exploding:
			return true
		elif freezing and exploding and not cracked:
			return true
		
	else:
		return false
	
	return false
	


func _on_mouse_entered() -> void:
	pass

func update_look():
	if broken and current_ability == null and not disabled:
	
		var new_theme: Theme = preload("res://Themes/Ability Themes/broken.tres")
		theme = new_theme
	elif not disabled:
		if current_ability is Cross:
			
			var new_theme:Theme = load("res://Themes/Ability Themes/Ice_Cross_Theme.tres")
			
			theme = new_theme
		elif current_ability is Star:
			var new_theme: Theme = load("res://Themes/Ability Themes/Fire_Star.tres")
			
			theme = new_theme
		
		elif current_ability is Smash:
			var new_theme: Theme = load("res://Themes/Ability Themes/Smasher.tres")
			
			theme = new_theme
			
		else:
			
			if freezing and not exploding:
				var new_theme: Theme = load("res://Themes/Ability Themes/frozen.tres")
				theme = new_theme
				
			
			elif exploding and not freezing:
				var new_theme: Theme = load("res://Themes/Ability Themes/burning.tres")
				theme = new_theme
			
			elif exploding and freezing:
				var new_theme: Theme = load("res://Themes/Ability Themes/cracked.tres")
				theme = new_theme
				
			elif cracked:
			
				var new_theme: Theme = load("res://Themes/Ability Themes/cracked.tres")
				theme = new_theme
			else:
		
				var new_theme: Theme = load("res://Themes/Ability Themes/default.tres")
				theme = new_theme
	
func reset():
	exploding = false
	freezing = false
	cracked = false
	broken = false
	current_ability = null
	theme = load("res://Themes/Ability Themes/default.tres")
	self_modulate = Color(1,1,1,1)


func _on_gui_input(event: InputEvent) -> void:
	var stage: Stages = get_tree().get_first_node_in_group("stages")
	
	if stage != null:
		if event.is_action_released("Select") and stage.game_running and disabled == false:
			stage.player_choice = self
