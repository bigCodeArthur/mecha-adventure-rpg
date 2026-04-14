class_name Player extends Node3D

var selectedCharacter: Character
var rng = RandomNumberGenerator.new()
var pan: bool = false
var last_mouse_pos: Vector2
var MOUSE_SENSITIVITY = 0.005


@export var team_manager: TeamManager
@export var player_team : Team
@export var ui: PlayerUI
@export var battle_manager: BattleManager
@onready var cam: Camera3D = %Camera3D
@onready var ray: RayCast3D = %RayCast3D
@onready var pivot: Node3D = $pivot

signal characterChanged(char: Character)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("zoom_in"): cam.position.z -= 3
	if Input.is_action_just_pressed("zoom_out"): cam.position.z += 3
	cam.position.z = clamp(cam.position.z, 3, 30)
	
	if Input.is_action_just_pressed("next_character"): 
		selectCharacter(player_team.get_next(selectedCharacter))
	if Input.is_action_just_pressed("prev_character"):
		selectCharacter(player_team.get_prev(selectedCharacter))
	
	if Input.is_action_just_pressed("pan"): pan = true
	if Input.is_action_just_released("pan"): pan = false
	
	if Input.is_action_just_pressed("cam_move"):
		last_mouse_pos = get_viewport().get_mouse_position()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif Input.is_action_just_released("cam_move"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Input.warp_mouse(last_mouse_pos)

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var dir := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if dir: position += dir * delta * 10

	handle_debug_randomizer()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and \
	event.button_index == MouseButton.MOUSE_BUTTON_LEFT and \
	event.pressed:
		var mouse_pos = get_viewport().get_mouse_position() 
		var from = cam.project_ray_origin(mouse_pos)
		var dir  = cam.project_ray_normal(mouse_pos)
		var to   = from + dir * 1000.0

		ray.position = from
		ray.target_position = to
		ray.force_raycast_update() # because it is a single frame action
		if ray.is_colliding(): 
			var character = ray.get_collider()
			if character is Area3D:
				selectCharacter(character.character)

	move_camera(event)


func move_camera(event: InputEvent):
	if event is InputEventMouseMotion and \
	Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if pan:
			var pan_value = Vector3(
				-event.relative.x * (MOUSE_SENSITIVITY * cam.position.z),
				0,
				-event.relative.y * (MOUSE_SENSITIVITY * cam.position.z)
			)
			position += pan_value.rotated(Vector3.UP, rotation.y)
		else:
			rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
			ui.stick.rot_offset = rotation.y
			pivot.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
			pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-90), deg_to_rad(0));


func selectCharacter(character: Character, prev_character: Character = selectedCharacter) ->void:
	if character is not Character: return
	if character == null: return
	if character.team != player_team: return
	if prev_character == character: return
	if prev_character != null: prev_character.deselect()

	if  character != null:
		character.select()
		emit_signal("characterChanged", character)
		ui.stick.usable = true
		selectedCharacter = character
	else:
		selectedCharacter = null


func deselect() -> void:
	selectCharacter(null)


func handle_debug_randomizer():
	if Input.is_action_just_pressed("ui_cut"):
		for character in team_manager.get_all_characters():
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
