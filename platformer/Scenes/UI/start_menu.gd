extends PanelContainer

class_name StartMenu
signal stage_selected(stage: StageResource)

var selected_stage: StageResource

@onready var stage_list: ItemList = %StageList
@onready var start_button: Button = %StartButton
var number_of_stages: int = 0

func _ready() -> void:
	GameSaver.delete_data()
	GameSaver.load_map()
	
	
	if GameState.stage_data.is_empty():
		var list: Array[StageResource] = []
		while number_of_stages < 21:
			var stage_resource: StageResource = StageResource.new()
			stage_resource.stage_name = "Stage: " +  str(number_of_stages + 1)
			
			var dir = DirAccess.open("res://Scenes/Stages")
			
			dir.list_dir_begin()
			
			var file = dir.get_next()
			
			while file != "":
			
				var stage_num: int = number_of_stages + 1
				
				if file == "stage_" + str(stage_num) + ".tscn":
					stage_resource.scene_path = "res://Scenes/Stages/" + file
			
				file = dir.get_next()
				
			
			if stage_resource.stage_name == "Stage: 1":
				stage_resource.required_precedent_completed == true
			
			list.append(stage_resource)
			
			number_of_stages += 1
		GameState.stage_data = list
	
	
	for stage:StageResource in GameState.stage_data:
		if stage.stage_name == "Stage: 1":
			print(stage.stage_name, stage.all_rounds_completed, stage.required_precedent_completed )
			if stage.required_precedent_completed == false:
				print("turned_true")
				stage.required_precedent_completed = true
			else:
				print("it was already true")
	
		var index = stage_list.add_item(stage.stage_name)
		stage_list.set_item_metadata(index, stage)


func _on_stage_list_item_selected(index: int) -> void:
	selected_stage = stage_list.get_item_metadata(index)
	if selected_stage.required_precedent_completed == false:
		start_button.disabled = false
	else:
		start_button.disabled = false
		
	
	

func _on_start_button_pressed() -> void:
	stage_selected.emit(selected_stage)
	
