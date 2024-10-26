extends Stages


func _ready() -> void:
	
	choice_timer = %ChoiceTimer
	choice_timer.timeout.connect(_round_ended)
	hazards = {
		"round1": {
			"cross": 2,
			"star": 2,
			"smasher": 2
		},
		"round2": {
			"cross": 1,
			"star": 5,
			"smasher" : 3
		},
		"round3": {
			"cross": 6,
			"star": 1,
			"smasher": 7
		}
	}

	col = 15
	row = 10
	
	
	var list: Array[int] = []
	for numbers: int in range(col * row):
		if numbers % col == 0 or numbers % col == col - 1 or numbers / col == 0 or numbers / col == row - 1:
			continue
		else:
			list.append(numbers)
	
	set_up_grid(list)
	
	

func begin_game():
	
	
	game_running = true
	var ui: MainUI = get_tree().get_first_node_in_group("ui")
	
	choice_timer.wait_time = 6
	choice_timer.start()
	
	ui.t_imer_label.text = str(choice_timer.wait_time)
