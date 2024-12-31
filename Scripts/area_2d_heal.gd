extends Area2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("_Healing"):
		var Play= body as playerScript
		Play._Healing(true)
		if ((Play.CurrentNergy < Play.maxEnergy) and !audio_stream_player_2d.playing):
			audio_stream_player_2d.play()
		
func _on_body_exited(_body: Node2D) -> void:
	if _body.has_method("_Healing"):
		var Play= _body as playerScript
		Play._Healing(false)
		audio_stream_player_2d.stop()
