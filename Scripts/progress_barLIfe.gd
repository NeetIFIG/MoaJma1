extends TextureProgressBar
@export var Player : playerScript

func _ready() -> void:
	Player.healthChange.connect(update)
	update()

func update():
	value = Player.CurrentHealth * 100 / Player.maxHealth
