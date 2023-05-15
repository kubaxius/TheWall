extends State

var default_modulate = Color(1, 1, 1, 1)
var button_pressed_modulate = Color(1, 1, .38, 1)

func _s_physics_process(delta):
	parent.move_hand()
	if Input.is_action_just_released(parent.input_name):
		state_machine.current_state = "Free"
	
	if Input.is_action_pressed(parent.input_name):
		parent.modulate = button_pressed_modulate
	else:
		parent.modulate = default_modulate

func _s_input(event):
	if event is InputEventMouseMotion:
		parent.desired_position += event.relative
