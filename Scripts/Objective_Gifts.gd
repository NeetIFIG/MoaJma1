extends Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var timer: Timer = $GPUParticles2D/Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	sprite_2d.visible=false
	gpu_particles_2d.emitting=false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PLayerBody" and timer.is_stopped():
		sprite_2d.visible=true
		gpu_particles_2d.emitting=true
		audio_stream_player_2d.play()
		timer.start()
	

func _on_timer_timeout() -> void:
	if (get_tree().current_scene.name == "World1"):
		get_tree().change_scene_to_file("res://Scenes/world_2.tscn")
	else:
		print("No more levels")
