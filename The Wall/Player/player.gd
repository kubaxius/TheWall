extends KinematicBody2D

var WALKING_SPEED = 600
var JUMP_POWER = 600
var GRAVITY = 20
var MAX_SPEED = 1000
var MID_AIR_CONTROL_MULTIPLIER = 0.6
var FRICTION = 0.2

var velocity = Vector2()
var velocity_relative_to_globe setget set_velocity_relative_to_globe, get_velocity_relative_to_globe
var up_direction setget ,get_up_direction

onready var HANDS = [$ArmLeft/Hand, $ArmRight/Hand]

var object_to_use

var anim_state_machine

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	anim_state_machine = $AnimationTree.get("parameters/playback")

func _physics_process(delta):
	set_rot()

func set_velocity_relative_to_globe(val: Vector2):
	velocity = val.rotated(self.up_direction.angle()+PI/2)

func get_velocity_relative_to_globe():
	return velocity.rotated(-(self.up_direction.angle()+PI/2))

func get_up_direction():
	return global_position.normalized()

func get_gravity_vector():
	return -GRAVITY * self.up_direction

func get_gripped_hands():
	var gripped_hands = []
	
	for hand in HANDS:
		if hand.get_node("StateMachine").current_state.name == "Gripping":
			gripped_hands.append(hand)
	
	return gripped_hands

func get_desired_x_velocity():
	var x_velocity = 0
	
	if Input.is_action_pressed("move_left"):
		x_velocity -= WALKING_SPEED
	if Input.is_action_pressed("move_right"):
		x_velocity += WALKING_SPEED
	
	return x_velocity

func limit_velocity():
	if velocity.length() > MAX_SPEED:
		velocity = velocity.clamped(MAX_SPEED)

func set_rot():
	rotation = self.up_direction.angle()+PI/2

func use_object():
	if is_instance_valid(object_to_use):
		object_to_use.try_to_use(self)
