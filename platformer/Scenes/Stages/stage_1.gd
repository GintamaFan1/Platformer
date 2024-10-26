extends Stages



func _ready() -> void:
	choice_timer = %ChoiceTimer
	choice_timer.timeout.connect(_round_ended)
	hazards = {
		"round1": {
			"cross": 2,
			"star": 1
		},
		"round2": {
			"cross": 2,
			"star": 2
		},
		"round3": {
			"cross": 3,
			"star": 1
		}
	}

	col = 5
	row = 5
	
	set_up_grid()
	
	

func begin_game():
	
	game_running = true
	var ui: MainUI = get_tree().get_first_node_in_group("ui")
	
	choice_timer.wait_time = 3
	choice_timer.start()
	
	ui.t_imer_label.text = str(choice_timer.wait_time)
	
