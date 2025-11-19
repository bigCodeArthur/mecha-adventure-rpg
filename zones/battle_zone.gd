extends Node3D
@onready var characters: Node3D = $characters
@onready var ui: Control = $UI

var allCharacters: Array[Node]
var unlockedPlayers: int = 0

func PLAY() -> void:
	pass

func PAUSE() -> void:
	pass

func _ready() -> void:
	for team in characters.get_children():
		for character in team.get_children():
			allCharacters.append(character)

func _physics_process(delta: float) -> void:
	for character in allCharacters:
		if character.actionLock <= 0:
			unlockedPlayers += 1
		else:
			character.actionLock -= 1

	if unlockedPlayers > 0:
		get_tree().paused = true
		ui.stick.usable = true
