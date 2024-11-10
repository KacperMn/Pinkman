extends Area2D

@onready var is_dead = false

func _on_body_entered(body):
	print("die")
	body.death()
