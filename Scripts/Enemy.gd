extends CharacterBody2D
var my_vectorVel = Vector2(0,0)
const SPEED = 50
#@export var Player : playerScript

func _ready() -> void:
	my_vectorVel.x = randf_range(0,1)
	my_vectorVel.y = randf_range(0,1)
	pass	
"""
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("_HurtPlayer"):
		var Play= body as playerScript
		Play._HurtPlayer(2)
"""	
func _physics_process(delta):
	var collision = move_and_collide( my_vectorVel.normalized() * SPEED * delta)
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
