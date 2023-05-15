extends State

func change_anims():
	if Helper.compare_floats(parent.velocity_relative_to_globe.x, 0, 5):
		if parent.anim_state_machine.get_current_node() != "Idle":
			parent.anim_state_machine.travel("Idle")
	elif parent.velocity_relative_to_globe.x > 0:
		if parent.anim_state_machine.get_current_node() != "WalkRight":
			parent.anim_state_machine.travel("WalkRight")
	elif parent.velocity_relative_to_globe.x < 0:
		if parent.anim_state_machine.get_current_node() != "WalkLeft":
			parent.anim_state_machine.travel("WalkLeft")

func _s_init():
	if not parent.get("HANDS") == null:
		for hand in parent.HANDS:
			if is_instance_valid(hand):
				hand.get_node("StateMachine").current_state = "Free"

func set_parent_velocity(delta):
	if Input.is_action_pressed("jump"):
		parent.velocity_relative_to_globe.y = -parent.JUMP_POWER
		state_machine.current_state = "MidAir"
	
	parent.velocity_relative_to_globe.y += parent.GRAVITY
	parent.velocity_relative_to_globe.x = lerp(parent.velocity_relative_to_globe.x, parent.get_desired_x_velocity(), parent.FRICTION)
	
	parent.velocity = parent.move_and_slide(parent.velocity, parent.up_direction)

func _s_process(delta):
	change_anims()
	if Input.is_action_just_pressed("interact"):
		parent.use_object()

func _s_physics_process(delta):
	set_parent_velocity(delta)
