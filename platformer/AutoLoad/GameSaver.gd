extends Node

func _ready() -> void:
	var dir = DirAccess.open("user://")
	
	if not dir.dir_exists("stage_data"):
		dir.make_dir("stage_data")


func save():
	print("game auto saved")
	var file_path: String = "user://stage_data/progress.tres"
	var data: ListSaver = ListSaver.new()
	data.data = GameState.stage_data
	
	
	ResourceSaver.save(data,file_path)
	
func load_map():
	var file_path: String = "user://stage_data/progress.tres"
	if FileAccess.file_exists(file_path):
		var data: ListSaver = ResourceLoader.load(file_path) as ListSaver
		
		GameState.stage_data = data.data
		
		
func delete_data():
	var file_path: String = "user://stage_data/progress.tres"
	if FileAccess.file_exists(file_path):
		var dir = DirAccess.open("user://stage_data/")
		dir.remove(file_path)
		
		
		
