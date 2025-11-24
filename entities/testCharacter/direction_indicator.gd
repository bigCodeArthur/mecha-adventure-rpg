extends Node3D

var selected : bool = false

@onready var test_character_body: CharacterBody3D = $".."
@onready var selection: MeshInstance3D = $Selection
@onready var pointer: MeshInstance3D = $Pointer

func _process(_delta: float) -> void:
	if selected:
		visible = true
	else:
		visible = false

	if test_character_body.target_direction == Vector2.ZERO:
		pointer.visible = false
		return 
	else:
		pointer.visible = true



	var target_direction = Vector3(
		test_character_body.target_direction.x,
		global_position.y,
		test_character_body.target_direction.y
	)

	look_at(global_position + target_direction)
