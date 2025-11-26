extends Node3D

var selectedCharacter: Node3D
@onready var player_team: Node3D = $"../Teams".get_child(0)
@onready var ui: Control = $"../UI"
@onready var battle_zone: Node3D = $".."
@onready var cam: Camera3D = $Camera3D
@onready var ray: RayCast3D = $RayCast3D

signal characterChanged(char: Character)


func _process(_delta: float) -> void:
	if  Input.is_action_just_pressed("ui_accept"):
		get_owner().PLAY()
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


func selectCharacter(prev_character: Character, character: Character) ->void:
	if  prev_character == character:
		return

	if prev_character != null:
		prev_character.deselect()

	if  character != null:
		character.select()
		emit_signal("characterChanged", character)
		ui.stick.usable = true
		selectedCharacter = character
