extends Actor

@onready var ray_cast_right = $CollisionShape2D/RayCastRight
@onready var ray_cast_left = $CollisionShape2D/RayCastLeft
@onready var ray_cast_bottom_right = $CollisionShape2D/RayCastBottomRight
@onready var ray_cast_bottom_left = $CollisionShape2D/RayCastBottomLeft

@export var speed = 50
var direction = -1

func _physics_process(delta):
	gravity(delta)
	
	walk(direction, speed)
	process_animation(direction, speed)
	
	if ray_cast_right.is_colliding() or not ray_cast_bottom_right.is_colliding():
		direction = -1
	elif ray_cast_left.is_colliding() or not ray_cast_bottom_left.is_colliding():
		direction = 1

	move_and_slide()
	
