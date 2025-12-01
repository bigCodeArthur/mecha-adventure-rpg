class_name Team extends Node3D

@onready var characters : Array[Character] = get_characters()

func get_characters() -> Array[Character]:
	var output : Array[Character]

	for child in get_children():
		if child is Character:
			output.append(child)

	return output
