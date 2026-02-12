class_name BattleManager extends Node3D

var unlockedPlayers : int = 0

@onready var player: Player = $Player
@onready var teamManager : TeamManager = $TeamManager
@onready var ui : PlayerUI = $"UI"
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
	var unlockedCharacters : Array[Character] = []

	for character in allCharacters:
		if  character.actionLock <= 0:
			unlockedCharacters.append(character)
			if character.activeAbility:
				character.actionLock = character.activeAbility.AnimationFrameLock
		
	if len(unlockedCharacters) > 0:
		PAUSE()
	else:
		for character in allCharacters:
			character.actionLock -= 1
