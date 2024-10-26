extends Stages


func _ready() -> void:
	
	choice_timer = %ChoiceTimer
	choice_timer.timeout.connect(_round_ended)
	hazards = {
		"round1": {
			"cross": 0,
			"star": 0,
			"smasher": 8
		},
		"round2": {
			"cross": 6,
			"star": 1,
			"smasher" : 5
		},
		"round3": {
			"cross": 6,
			"star": 7,
			"smasher": 6
		}
	}

	col = 8
	row = 10
	
	
	set_up_grid()

func begin_game():
	
	game_running = true
	var ui: MainUI = get_tree().get_first_node_in_group("ui")
	
	choice_timer.wait_time = 6
	choice_timer.start()
	
	ui.t_imer_label.text = str(choice_timer.wait_time)
