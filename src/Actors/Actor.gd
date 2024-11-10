extends CharacterBody2D
class_name Actor

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _animated_sprite = $AnimatedSprite2D

func jump(jump_velocity):
	velocity.y = jump_velocity
	
func walk(direction, speed):
	velocity.x = direction * speed
	
			
func process_animation(direction, speed):
	if direction < 0:
			$AnimatedSprite2D.flip_h = true
	elif direction > 0:
			$AnimatedSprite2D.flip_h = false
	
	if is_on_floor():
		if direction < 0:
			_animated_sprite.play("walk")
		elif direction > 0:
			_animated_sprite.play("walk")
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			_animated_sprite.play("idle")
	else:
		if velocity.y < 0:
			_animated_sprite.play("jumping")
		elif velocity.y >= 0:
			_animated_sprite.play("falling")

func gravity(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
