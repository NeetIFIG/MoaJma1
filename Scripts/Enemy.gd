extends CharacterBody2D
var my_vectorVel = Vector2(0,0)
const SPEED = 50
#@export var Player : playerScript
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	my_vectorVel.x = randf_range(-1,1)
	my_vectorVel.y = randf_range(-1,1)
"""
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("_HurtPlayer"):
		var Play= body as playerScript
		Play._HurtPlayer(2)
"""

		
func _physics_process(delta):
	var collision = move_and_collide( my_vectorVel* SPEED * delta)
	if collision:
		"""
		if (collision.get_collider().name == "PLayerBody"):
			if collision.get_collider().has_method("_HurtPlayer"):
				var Player = collision.get_collider() as playerScript
				Player._HurtPlayer(Damage)
		"""
		#velocity = velocity.slide(collision.get_normal())
		if(collision.get_collider().name != "PLayerBody"):
			my_vectorVel.x = randf_range(-1,1)
			my_vectorVel.y = randf_range(-1,1)
			#my_vectorVel= my_vectorVel * -1
	#move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	gpu_particles_2d.restart()
	gpu_particles_2d.emitting = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	gpu_particles_2d.restart()
	gpu_particles_2d.emitting = false
