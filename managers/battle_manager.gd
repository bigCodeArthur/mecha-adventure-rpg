extends Node3D

var unlockedPlayers : int = 0

@onready var player: Player = $Player
@onready var teamManager : TeamManager = $TeamManager
@onready var ui : PlayerUI = $UI
@onready var allCharacters : Array[Character] = teamManager.get_all_characters()


func PLAY() -> void:
	player.deselect()
	ui.stick.reset()
	get_tree().paused = false


func PAUSE() -> void:
	get_tree().paused = true


func _ready() -> void:
	PAUSE()


func _physics_process(_delta: float) -> void:
	unlockedPlayers = 0

	for character in allCharacters:
		if  character.actionLock > 0:
			character.actionLock -= 1
		else:
			unlockedPlayers += 1
			character.actionLock = character.activeAbility.AnimationFrameLock

	if unlockedPlayers > 0:
		PAUSE()
