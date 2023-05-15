extends Node2D

export(PackedScene) var next_scene

func _ready():
	$AnimationPlayer.play("FadeIn")

func load_next_level():
	$AnimationPlayer.play("FadeOut")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene_to(next_scene)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_BACKSPACE:
			load_next_level()


func _on_Gate_used():
	load_next_level()
