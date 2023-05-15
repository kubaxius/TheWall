extends KinematicBody2D
class_name Hand

export(float, 0.5, 1, 0.5) var MOVEMENT_SPEED = 0.1

onready var DEFAULT_POSITION = self.position
onready var desired_position = DEFAULT_POSITION
var input_name setget ,get_input_name
onready var arm = get_parent()

var gripped_position
onready var player_state_machine = find_parent("Player").get_node("StateMachine")

func get_input_name():
	if arm.ARM == arm.ARMS.LEFT:
		return "grab_with_left_hand"
	return "grab_with_right_hand"

func move_hand():
	
	# make step towards desired position
	position = lerp(position, desired_position, MOVEMENT_SPEED)
	position = position.clamped(arm.LENGTH)
	
	# limit mouse movement range but not speed
	if position.length() >= arm.LENGTH:
		desired_position = desired_position.clamped(arm.LENGTH)

func grip(gripped_object):
	gripped_position = global_position
	
	if $StateMachine.current_state.name == "Controlled":
		if Input.is_action_pressed(self.input_name):
			$StateMachine.current_state = "Gripping"
