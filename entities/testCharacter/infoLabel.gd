extends Label3D


@onready var body: Character_main = $".."


func _ready() -> void:
	text = str(body.actionLock)


func _process(_delta: float) -> void:
	text = str(body.actionLock)
