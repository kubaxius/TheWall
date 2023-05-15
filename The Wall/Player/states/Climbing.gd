extends State

var INERTIA_FACTOR = 0.1
var DOWN_MOVEMENT = 20
var INERTIA_AFTER_LETTING_GO = 60
var MOUSE_SENSITIVITY = 20

func _s_init():
	parent.anim_state_machine.travel("SideToBack")

func move():
	var hands: Array = parent.get_gripped_hands()
	if hands.size() == 0:
		state_machine.current_state = "MidAir"
	else:
		for hand in hands:
			# ensure arm length
			var current_hand_to_arm_vector = hand.arm.global_position - hand.global_position
			var new_hand_to_arm_vector = current_hand_to_arm_vector + parent.velocity
			if new_hand_to_arm_vector.length() >= hand.arm.LENGTH:
				new_hand_to_arm_vector = new_hand_to_arm_vector.clamped(hand.arm.LENGTH)
				parent.velocity = new_hand_to_arm_vector - current_hand_to_arm_vector
		
		parent.move_and_collide(parent.velocity)
		parent.velocity = lerp(parent.velocity, Vector2(0, 0), INERTIA_FACTOR)

func _s_physics_process(delta):
	parent.velocity.y += DOWN_MOVEMENT
	parent.velocity *= delta
	move()

func _s_input(event):
	if event is InputEventMouseMotion:
		parent.velocity += event.relative * MOUSE_SENSITIVITY

func _s_exit():
	parent.velocity = parent.velocity * INERTIA_AFTER_LETTING_GO
