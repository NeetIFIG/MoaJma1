extends Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	sprite_2d.visible=false
	gpu_particles_2d.emitting=false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PLayerBody":
		sprite_2d.visible=true
		gpu_particles_2d.emitting=true
