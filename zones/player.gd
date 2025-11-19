extends Node3D
var selectedCharacter: Node3D
#TODO: debug value ---
@onready var test_character: Node3D = $"../characters/Team1/testCharacter"
# ---
@onready var ui: Control = $"../UI"
@onready var battle_zone: Node3D = $".."

func _ready() -> void:
	get_tree().paused = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().paused = false
		ui.stick.usable = false

	if Input.is_action_just_pressed("ui_cancel"):
		selectCharacter(test_character)
		print(selectedCharacter.name)
		ui.stick.usable = true

func selectCharacter(character: Node3D) ->void:
	selectedCharacter = character

func _on_stick_value_changed(value: Vector2) -> void:
	if selectedCharacter:
		selectedCharacter.to = value
		selectedCharacter.speedStrength = value.length()
	else:
		print("select a character my nigga")
