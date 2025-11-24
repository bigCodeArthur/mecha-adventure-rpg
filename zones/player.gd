extends Node3D

var selectedCharacter: Node3D

@onready var player_team: Node3D = $"../characters/Team1"
@onready var ui: Control = $"../UI"
@onready var battle_zone: Node3D = $".."
@onready var cam: Camera3D = $Camera3D
@onready var ray: RayCast3D = $RayCast3D


func _process(_delta: float) -> void:
	if  Input.is_action_just_pressed("ui_accept"):
		get_tree().paused = false
		ui.stick.usable = false
		selectCharacter(selectedCharacter, null)


func _unhandled_input(event: InputEvent) -> void:
	if  event is InputEventMouseButton and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_viewport().get_mouse_position()
		var from = cam.project_ray_origin(mouse_pos)
		var dir  = cam.project_ray_normal(mouse_pos)
		var to   = from + dir * 1000.0

		ray.position = from
		ray.target_position = to
		ray.force_raycast_update() # because it is a single frame action

		if ray.is_colliding():
			selectCharacter(selectedCharacter, ray.get_collider())
		else:
			selectCharacter(selectedCharacter, null)


func selectCharacter(prev_character: Node3D, character: Node3D) ->void:
	print("prev:", prev_character, "char", character)
	if  prev_character == character:
		return

	if prev_character != null:
		prev_character.deselect()

	if  character != null:
		character.select()
		ui.stick.usable = true
		ui.stick.value = character.target_direction
		selectedCharacter = character
	else:
		selectedCharacter = null
		ui.stick.value = Vector2.ZERO
		ui.stick.usable = false


func _on_stick_value_changed(value: Vector2) -> void:
	if  selectedCharacter:
		selectedCharacter.target_direction = value
		selectedCharacter.speedStrength = value.length()
	else:
		print("select a character")
