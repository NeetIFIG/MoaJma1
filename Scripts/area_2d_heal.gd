extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("_Healing"):
		var Play= body as playerScript
		Play._Healing(true)
		
func _on_body_exited(_body: Node2D) -> void:
	if _body.has_method("_Healing"):
		var Play= _body as playerScript
		Play._Healing(false)
