extends CharacterBody2D

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ROTATION_AMOUNT = 12

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if(velocity.y !=0 || velocity.x!=0):
		gpu_particles_2d.emitting = 1
		sprite_2d.set_rotation_degrees (ROTATION_AMOUNT*direction)
	else:
		gpu_particles_2d.emitting = 0
		sprite_2d.set_rotation_degrees(0)
		
		
	if Input.is_action_just_pressed("ExitGame"):
		get_tree().quit()

	move_and_slide()
