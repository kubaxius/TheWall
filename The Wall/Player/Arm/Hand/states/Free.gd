extends State

func _s_init():
	parent.desired_position = parent.DEFAULT_POSITION

func _s_physics_process(delta):
	parent.move_hand()
	if Input.is_action_pressed(parent.input_name)\
	 || parent.player_state_machine.current_state.name == "Climbing":
		state_machine.current_state = "Controlled"
