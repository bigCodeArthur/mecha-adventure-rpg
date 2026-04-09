class_name BattleManager extends Node3D
## BattleManager.
##
## manages aspects of the battle like playing/pausing and ability timers.


var unlockedPlayers : int = 0

@export var player: Player
@export var teamManager: TeamManager
@export var ui: PlayerUI
@onready var allCharacters : Array[Character_main] = teamManager.get_all_characters()


func PLAY() -> void:
	player.deselect()
	ui.stick.reset()
	process_mode = Node.PROCESS_MODE_INHERIT
	# get_tree().paused = false


func PAUSE() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	# get_tree().paused = true


func _ready() -> void:
	PAUSE()


func _physics_process(_delta: float) -> void:
	unlockedPlayers = 0
	var unlockedCharacters : Array[Character_main] = []

	for character in allCharacters:
		if  character.actionLock <= 0:
			unlockedCharacters.append(character)
			character.set_active_ability(null)
		
	if len(unlockedCharacters) > 0:
		PAUSE()
	else:
		for character in allCharacters:
			character.actionLock -= 1
