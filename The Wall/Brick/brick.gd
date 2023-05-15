extends Area2D
tool

func _on_Brick_body_entered(body):
	if body is Hand:
		body.grip(self)

func _process(delta):
	rotation = global_position.angle() + PI/2
