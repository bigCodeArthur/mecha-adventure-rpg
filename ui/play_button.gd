extends Button
@onready var ui: PlayerUI = $".."

func _pressed() -> void:
	ui.PLAY()
