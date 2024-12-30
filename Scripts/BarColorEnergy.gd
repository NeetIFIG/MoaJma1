extends ProgressBar
@export var Player : playerScript

func _ready() -> void:
	var sbf = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sbf)
	sbf.bg_color = Color(0.204, 0.941, 0.839)
	Player.EnergyChange.connect(_update)
	_update()

func _update():
	value = Player.CurrentNergy * 100 / Player.maxEnergy
	
