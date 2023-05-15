extends Area2D

export(NodePath) var key = ""

var used = false
signal used

func _ready():
	if not key == "":
		key = get_node(key)

func _on_UsableObject_body_entered(body):
	if body.name == "Player":
		body.object_to_use = self


func _on_UsableObject_body_exited(body):
	if body.name == "Player":
		body.object_to_use = null

func try_to_use(player):
	if is_instance_valid(key):
		if key.used:
			use()
		else:
			locked()
	else:
		use()

func use():
	used = true
	emit_signal("used")
	print("used " + name)

func locked():
	print("locked!")
