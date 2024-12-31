extends CharacterBody2D
class_name playerScript
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer
@export var maxHealth = 10
@onready var CurrentHealth : float = maxHealth
@export var maxEnergy := 5
@onready var  CurrentNergy : float = maxEnergy
@onready var isFlying = false
@onready var CanFly = true
@onready var UnderAttack = false
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var audio_stream_player_2d_3: AudioStreamPlayer2D = $AudioStreamPlayer2D3

signal healthChange
signal EnergyChange
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const ROTATION_AMOUNT = 12

func  _ready() -> void:
	healthChange.emit()
	EnergyChange.emit()
func _physics_process(delta: float) -> void:
	if  (CurrentHealth <= 0):
		return
	#Gravity
	if not is_on_floor() and !isFlying:
		velocity += get_gravity() * delta
	# Handle jump.    
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and !isFlying:
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_pressed("ActivateFly") and CanFly:
		isFlying = true
		if(!audio_stream_player_2d.playing):
			audio_stream_player_2d.play()
		var directionY := Input.get_axis("ui_up", "ui_down")
		if directionY:
			velocity.y = directionY * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		isFlying = false
		audio_stream_player_2d.stop()
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
	move_and_slide()
	if Input.is_action_just_pressed("ExitGame"):
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
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
	if(UnderAttack):
		CurrentHealth = clamp(CurrentHealth - 1.5 * delta, 0, maxHealth)
		healthChange.emit()
		if (!audio_stream_player_2d_3.playing):
			audio_stream_player_2d_3.play()
		if (CurrentHealth <= 0 && timer.is_stopped()):
			Death()
	gpu_particles_2d.emitting = isFlying

func Death() -> void:
	audio_stream_player_2d_2.play()
	Engine.time_scale = 0.5
	#self.get_node("CollisionShape2D").queue_free()
	timer.start()

func _Healing(value : bool) -> void:
	IsRecivingEnergy=value
	CanFly = true

func _HurtPlayer(value : bool) -> void:
	UnderAttack=value
	#CurrentHealth = clamp(CurrentHealth - value, 0, maxHealth)
	#print(CurrentHealth)
	#healthChange.emit()
	
func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
