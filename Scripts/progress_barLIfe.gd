extends TextureProgressBar
@export var Player : playerScript

func _ready() -> void:
	value= Player.maxHealth
	Player.healthChange.connect(update)
	update()

func update():
	value = Player.CurrentHealth * 100 / Player.maxHealth
