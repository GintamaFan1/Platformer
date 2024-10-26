extends PanelContainer

class_name RoundEnd

@onready var info_label: Label = %InfoLabel
@onready var confirm_button: Button = %ConfirmButton
@onready var retry_button: Button = %RetryButton
var selected_next_stage: StageResource

func round_passed(round_num: int):
	if round_num in [1,2]:
		info_label.text = "Round Succeded"
		confirm_button.text = "Next Round"
		confirm_button.pressed.connect(round_manager)
	else:
		info_label.text = "Level Completed"
		confirm_button.text = "Next Level"
	
		var stage: Stages = get_tree().get_first_node_in_group("stages")
		
		confirm_button.pressed.connect(next_level.bind(stage))
		
		
		
		var previous_stage: StageResource
		for resource in GameState.stage_data:
		
			if resource.scene_path == stage.scene_file_path:
				print(stage.name + " Turned true")
				resource.all_rounds_completed = true
				
			if previous_stage != null:
				if previous_stage.all_rounds_completed:
					print("changing " + resource.stage_name + " true")
					resource.required_precedent_completed = true
			previous_stage = resource
			
			
			
		GameSaver.save()
		
		retry_button.text = "Retry Level"
		retry_button.pressed.connect(retry_level)

	
func wrong_tile_chosen():
	info_label.text = "You did not survive!"
	confirm_button.text = "Retyr Round"
	
	confirm_button.pressed.connect(round_manager)
	


	
func round_manager():
	
	var grid: Grid = get_tree().get_first_node_in_group("grid")
	var confirm_ready: ConfirmReady = get_tree().get_first_node_in_group("confirm ready")
	
	for tiles in grid.all_tiles:
		tiles.reset()
		
	confirm_ready.visible = true
	
	queue_free()
	
	

func next_level(current_stage: Stages):
	var previous_stage: StageResource
	for resource in GameState.stage_data:
		if previous_stage != null:
			selected_next_stage = resource
			break
		if resource.scene_path == current_stage.scene_file_path:
			previous_stage = resource
		
	
	var ui: MainUI = get_tree().get_first_node_in_group("ui")
	
	if selected_next_stage.scene_path != null:
		ui._on_start_menu_stage_selected(selected_next_stage)
	

func retry_level():
	var stage: Stages = get_tree().get_first_node_in_group("stages")
	var grid: Grid = get_tree().get_first_node_in_group("grid")
	var confirm_ready: ConfirmReady = get_tree().get_first_node_in_group("confirm ready")
	
	stage.round1_complete = false
	stage.round2_complete = false
	stage.round3_complete = false
	stage.current_round = 1
	for tiles in grid.all_tiles:
		tiles.reset()
		
	confirm_ready.visible = true
	
	queue_free()
	
	
