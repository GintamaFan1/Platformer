extends PanelContainer

class_name ConfirmReady

func _ready() -> void:
	pass


func _on_visibility_changed() -> void:
	if visible:
		get_tree().paused = true
	


func _on_ready_button_pressed() -> void:
	visible = false
	get_tree().paused = false
	var stage: Stages = get_tree().get_first_node_in_group("stages")
	stage.generate_hazards()
