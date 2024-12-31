extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game_Main.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menuCredits.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ExitGame"):
		get_tree().quit()
