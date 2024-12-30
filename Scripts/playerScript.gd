extends CharacterBody2D
class_name playerScript
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var maxHealth = 30
@onready var CurrentHealth : int = maxHealth
@export var maxEnergy := 5
@onready var  CurrentNergy : float = maxEnergy
@onready var isFlying = false
@onready var CanFly = true
signal healthChange
signal EnergyChange
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ROTATION_AMOUNT = 12
func _physics_process(delta: float) -> void:
	#Gravity
	if not is_on_floor() and !isFlying:
		velocity += get_gravity() * delta
	# Handle jump.    
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and !isFlying:
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("ActivateFly") and CanFly:
		isFlying = true
		var directionY := Input.get_axis("ui_up", "ui_down")
		if directionY:
			velocity.y = directionY * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		isFlying = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	"""
	if((velocity.y !=0 || velocity.x!=0) and isFlying):
		gpu_particles_2d.emitting = 1
	else:
		gpu_particles_2d.emitting = 0
	"""
	sprite_2d.set_rotation_degrees (ROTATION_AMOUNT*direction)
	
	if Input.is_action_just_pressed("ExitGame"):
		get_tree().quit()

	move_and_slide()
	
@onready var IsRecivingEnergy = false

func _process(delta: float) -> void:
	if(IsRecivingEnergy):
		CurrentNergy =clamp(CurrentNergy + delta * 1.5, 0, maxEnergy) 
		EnergyChange.emit()
	elif (isFlying and CanFly):
		CurrentNergy = clamp(CurrentNergy - delta * 1.5, 0, maxEnergy) 
		EnergyChange.emit()
		if (CurrentNergy <= 0):
			CanFly = false
	
	if isFlying:
		gpu_particles_2d.emitting = true
	else:
		gpu_particles_2d.emitting =false

func _Healing(value : bool) -> void:
	IsRecivingEnergy=value
	CanFly = true

func _on_gpu_particles_2d_finished() -> void:
	pass
	#gpu_particles_2d.restart()
