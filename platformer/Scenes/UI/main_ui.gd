extends Node

class_name MainUI

@onready var stage_holder: Control = %StageHolder
@onready var start_menu: StartMenu = %StartMenu
@onready var stage_name_label: Label = %StageNameLabel
@onready var t_imer_label: Label = %TImerLabel
@onready var round_label: Label = %RoundLabel





func _on_start_menu_stage_selected(stage: StageResource) -> void:

	var old_stage: Stages = get_tree().get_first_node_in_group("stages")
	
	if old_stage == null:
		var stage_node:Stages = load(stage.scene_path).instantiate()
		
		stage_holder.call_deferred("add_child", stage_node)
		stage_name_label.text = stage.stage_name
		
		start_menu.queue_free()
	
	else:
	
		stage_holder.remove_child(old_stage)
		old_stage.queue_free()
		
		var stage_node:Stages = load(stage.scene_path).instantiate()
		
		stage_holder.call_deferred("add_child", stage_node)
		stage_name_label.text = stage.stage_name
		
		
		
	
