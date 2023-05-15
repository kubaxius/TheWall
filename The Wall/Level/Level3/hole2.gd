extends "res://UsableObject/usable_object.gd"

func use():
	var player = get_tree().get_nodes_in_group("PLAYER")[0]
	player.anim_state_machine.travel("Hit")
	yield(get_tree().create_timer(1), "timeout")
	$crack.hide()
	$Light2D.show()
	$hole2.show()
	.use()
