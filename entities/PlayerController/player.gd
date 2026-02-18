class_name Player extends Node3D

var selectedCharacter : Node3D
var rng = RandomNumberGenerator.new()
var cam_move : bool = false
var MOUSE_SENSITIVITY = 0.005


@onready var player_team : Team = $"../TeamManager".get_player_team()
@onready var ui : Control = $"../UI"
@onready var battle_manager : BattleManager = $".."
@onready var cam : Camera3D = %Camera3D
@onready var ray : RayCast3D = %RayCast3D
@onready var pivot: Node3D = $pivot

signal characterChanged(char: Character)


func _process(_delta: float) -> void:
	if Input.is_action_pressed("cam_move"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		cam_move = true
	elif Input.is_action_just_released("cam_move"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		cam_move = false

	var dir := Input.get_vector("left", "right", "forward", "backward")
	if dir: position += Vector3(dir.x, 0, dir.y) / 3

	handle_debug_randomizer()


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

	move_camera(event)


func move_camera(event: InputEvent):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		pivot.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90));


func selectCharacter(prev_character: Character, character: Character) ->void:
	if character is not Character and character != null: return
	if prev_character == character: return
	if prev_character != null: prev_character.deselect()

	if  character != null:
		character.select()
		emit_signal("characterChanged", character)
		ui.stick.usable = true
		selectedCharacter = character

func deselect() -> void:
	selectCharacter(selectedCharacter, null)


func handle_debug_randomizer():
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
