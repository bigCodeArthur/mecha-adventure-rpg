extends Node3D

var allCharacters: Array[Node]
var unlockedPlayers: int = 0

@onready var teams: Node3D = $TeamManager
@onready var ui: Control = $UI


func PLAY() -> void:
	ui.stick.usable = false
	get_tree().paused = false


func PAUSE() -> void:
	ui.stick.usable = true
	get_tree().paused = true


func _ready() -> void:
	PAUSE()
	for team in teams.get_children():
		for character in team.get_children():
			allCharacters.append(character)


func _physics_process(_delta: float) -> void:
	unlockedPlayers = 0
	for character in allCharacters:
		if  character.actionLock > 0:
			character.actionLock -= 1
		else:
			unlockedPlayers += 1
			character.actionLock = 100

	if unlockedPlayers > 0:
		PAUSE()
