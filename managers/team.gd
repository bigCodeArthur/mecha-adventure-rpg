class_name Team extends Node3D

@onready var characters : Array[Character] = get_characters()
@export var team_color : Color = Color(0.0, 0.0, 0.827, 1.0):
	set(value):
		team_color = value
		for child in get_characters():
			child.set_color(team_color)


func _ready() -> void:
	for child in get_characters():
		child.set_color(team_color)


func get_characters() -> Array[Character]:
	var output : Array[Character]

	for child in get_children():
		if child is Character:
			output.append(child)

	return output
