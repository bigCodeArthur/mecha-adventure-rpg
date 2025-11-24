extends Node3D
@onready var characters: Node3D = $characters
@onready var ui: Control = $UI

var allCharacters: Array[Node]
var unlockedPlayers: int = 0

func PLAY() -> void:
	ui.stick.usable = false
	get_tree().paused = false

func PAUSE() -> void:
	ui.stick.usable = true
	get_tree().paused = true


func _ready() -> void:
	PAUSE()
	for team in characters.get_children():
		for character in team.get_children():
			allCharacters.append(character)

func _physics_process(_delta: float) -> void:
	for character in allCharacters:
		if character.actionLock <= 0:
			unlockedPlayers += 1
		else:
			character.actionLock -= 1

	if unlockedPlayers > 0:
		PAUSE()
