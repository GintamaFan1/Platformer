extends Stages


func _ready() -> void:
	
	choice_timer = %ChoiceTimer
	choice_timer.timeout.connect(_round_ended)
	hazards = {
		"round1": {
			"cross": 2,
			"star": 2,
			"smasher": 16
		},
		"round2": {
			"cross": 10,
			"star": 11,
			"smasher" : 9
		},
		"round3": {
			"cross": 11,
			"star": 11,
			"smasher": 11
		}
	}

	col = 15
	row = 10
	
	var list: Array[int] = [65,66,67,68,80,81,82,83,95,96,97,98]
	
	set_up_grid(list)
	
	

func begin_game():
	
	
	game_running = true
	var ui: MainUI = get_tree().get_first_node_in_group("ui")
	
	choice_timer.wait_time = 6
	choice_timer.start()
	
	ui.t_imer_label.text = str(choice_timer.wait_time)
