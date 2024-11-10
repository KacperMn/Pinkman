extends Area2D

@onready var cc_duration = $Timer
var player = 0
var kb_strength = 150.0

func knockback(body):
	cc_duration.start()
	body.can_move = false
	
	var kb_direction = 0
	if self.global_position.x < body.global_position.x:
		kb_direction = 1
	elif self.global_position.x == body.global_position.x:
		kb_direction = 0
	elif self.global_position.x > body.global_position.x:
		kb_direction = -1
		
	body.velocity = Vector2(kb_direction * kb_strength, -1 * kb_strength)

func _on_body_entered(body):
	player = body
	knockback(body)
	player.damage()

func _on_timer_timeout():
		player.can_move = true
