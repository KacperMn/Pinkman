extends Actor

@onready var death_animation_timer = $Death_animation_timer
@onready var deathscreen = $Deathscreen
@onready var you_died = $Overlay/you_died
@onready var scoreboard = $Overlay/scoreboard
@onready var coyote_timer = $Coyote_timer
@onready var health_bar = $Overlay/health_bar

#movement variables
@export var speed : float = 150.0
@export var jump_velocity : float = -330.0
var can_jump : bool = true

#crowd control variables
var can_move = true

#character variables
var score = 0
var lives = 3

#going to the next scene
func next_level():
	var current_scene_filepath = get_tree().current_scene.scene_file_path
	var next_scene_number = int(current_scene_filepath) + 1
	var next_scene_filepath = "res://src/Levels/level_" + str(next_scene_number) + ".tscn"
	get_tree().change_scene_to_file(next_scene_filepath)

#damage handling
func damage():
	_animated_sprite.play("damage")
	lives -= 1
	print(str(lives))

func process_health_bar():
	health_bar.set_frame_and_progress(lives, 0)
	if lives == 0:
		death()
		lives = 3

#death handling
func death():
	deathscreen.visible = true
	you_died.visible = true
	Engine.time_scale = 0.2
	death_animation_timer.start()
func _on_death_animation_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func movement_process():
	if can_move == true:
		#check direction
		var direction = Input.get_axis("left", "right")
		#check if player can jump
		if is_on_floor():
			can_jump = true
		elif velocity.y < 0:
			can_jump = false
		else:
			coyote_timer.start()
		#jump
		if Input.is_action_just_pressed("jump") and can_jump == true:
			jump(jump_velocity)
		#walk
		walk(direction, speed)
		#animation processing
		process_animation(direction, speed)

#physics processing
func _physics_process(delta):
	gravity(delta)
	movement_process()
	move_and_slide()

func _process(_delta):
	scoreboard.text = "score " + str(score)
	process_health_bar()

#coyote timer handling
func _on_coyote_timer_timeout():
	can_jump = false
