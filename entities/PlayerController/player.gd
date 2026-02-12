class_name Player extends Node3D

var selectedCharacter : Node3D
var rng = RandomNumberGenerator.new()

@onready var player_team : Team = $"../TeamManager".get_player_team()
@onready var ui : Control = $"../UI"
@onready var battle_manager : BattleManager = $".."
@onready var cam : Camera3D = $Camera3D
@onready var ray : RayCast3D = $RayCast3D

signal characterChanged(char: Character)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cut"):
		for team in battle_manager.teamManager.get_children():
			for child in team.get_children():
				if child is not Character_main: continue
				var character : Character_main = child
				character.set_active_ability(
					character.abilities[
						rng.randi_range(0, 
						len(character.abilities) - 1)
					]
				)
				
				character.target_direction = Vector2(
					rng.randf_range(-1, 1), 
					rng.randf_range(-1, 1)
				).normalized()
				
				character.speedStrength = rng.randf_range(0, 1)


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
	if character is not Character and character != null:
		return

	if  prev_character == character:
		return

	if  prev_character != null:
		prev_character.deselect()

	if  character != null:
		character.select()
		emit_signal("characterChanged", character)
		ui.stick.usable = true
		selectedCharacter = character

func deselect() -> void:
	selectCharacter(selectedCharacter, null)
