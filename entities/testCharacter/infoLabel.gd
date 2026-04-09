extends Label3D


@onready var body: Character_main = $".."


func _ready() -> void:
	text = create_text()


func _process(_delta: float) -> void:
	text = create_text()


func create_text() -> String:
	var new_text : String
	if body.activeAbility: new_text = str(body.actionLock)
	else: new_text = "__"
	return new_text
