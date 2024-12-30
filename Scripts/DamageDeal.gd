extends Area2D
#const  Damage = 2
func _on_body_entered(body: Node2D) -> void:
	print("Enter: "+body.name)
	if body.has_method("_HurtPlayer"):
		var Play= body as playerScript
		Play._HurtPlayer(true)
		
func _on_body_exited(body: Node2D) -> void:
	print("Exit: " + body.name)
	if body.has_method("_HurtPlayer"):
		var Play= body as playerScript
		Play._HurtPlayer(false)
