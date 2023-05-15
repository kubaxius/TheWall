extends "res://UsableObject/usable_object.gd"

func use():
	$AnimationPlayer.play("DropLamp")
	yield($AnimationPlayer, "animation_finished")
	.use()
