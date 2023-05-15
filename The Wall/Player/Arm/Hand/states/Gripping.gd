extends State

func _s_init():
	if parent.player_state_machine.current_state.name != "Climbing":
		parent.player_state_machine.current_state = "Climbing"

func _s_process(delta):
	parent.global_position = parent.gripped_position
	if Input.is_action_just_released(parent.input_name):
		state_machine.current_state = "Free"
