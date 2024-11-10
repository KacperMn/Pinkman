extends Area2D		

func _on_body_entered(body):
	body.score += 1
	queue_free()

## update score
