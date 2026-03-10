extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const GRAVITY = 980.0

var tongue_scene = preload("res://tongue.tscn")
var coin_count = 0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		shoot_tongue()

func shoot_tongue():
	var tongue = tongue_scene.instantiate()
	get_parent().add_child(tongue)
	tongue.global_position = global_position
	# Direction toward mouse
	var mouse_pos = get_global_mouse_position()
	tongue.direction = (mouse_pos - global_position).normalized()

func add_coin():
	coin_count += 1
	print("Coins: ", coin_count)
