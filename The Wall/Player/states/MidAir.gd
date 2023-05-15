extends State

func change_sprites():
	if Helper.compare_floats(parent.velocity_relative_to_globe.x, 0, 5):
		if parent.anim_state_machine.get_current_node() != "Idle":
			parent.anim_state_machine.travel("Idle")
	elif parent.velocity_relative_to_globe.x > 0:
		if parent.anim_state_machine.get_current_node() != "WalkRight":
			parent.anim_state_machine.travel("WalkRight")
	elif parent.velocity_relative_to_globe.x < 0:
		if parent.anim_state_machine.get_current_node() != "WalkLeft":
			parent.anim_state_machine.travel("WalkLeft")

func have_different_signs(a, b):
	if a < 0:
		if b >= 0:
			return true
	elif a >= 0:
		if b < 0:
			return true
	return false

func _s_process(delta):
	change_sprites()

func _s_physics_process(delta):
	# add gravity
	parent.velocity_relative_to_globe.y += parent.GRAVITY
	
	# add player movement
	var desired_x_velocity = parent.get_desired_x_velocity() * parent.MID_AIR_CONTROL_MULTIPLIER 
	if desired_x_velocity != 0:
		# prevents slowing down because of button press
		if abs(parent.velocity_relative_to_globe.x) < abs(desired_x_velocity)\
		 or have_different_signs(parent.velocity_relative_to_globe.x, desired_x_velocity)\
		 or parent.velocity_relative_to_globe.x == 0:
			parent.velocity_relative_to_globe.x = lerp(parent.velocity_relative_to_globe.x, desired_x_velocity, parent.FRICTION)
	
	parent.limit_velocity()
	parent.velocity = parent.move_and_slide(parent.velocity, parent.up_direction)
	
	if parent.is_on_floor():
		state_machine.current_state = "Walking"
