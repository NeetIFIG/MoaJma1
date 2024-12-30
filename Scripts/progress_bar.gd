extends ProgressBar
@export var Player : playerScript

func _ready() -> void:
	Player.EnergyChange.connect(update)
	update()

func update():
	value = Player.CurrentNergy * 100 / Player.maxEnergy
