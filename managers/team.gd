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


func _physics_process(_delta: float) -> void:
	for child in get_characters():
		child.set_color(team_color)


func get_first_character() -> Character:
	return get_characters()[0]


func get_next(input: Character) -> Character:
	if input == null: return get_first_character()
	var index = input.get_index()
	return get_child(wrap(index + 1, 0, get_child_count()))


func get_prev(input: Character) -> Character:
	if input == null: return get_first_character()
	var index = input.get_index()
	return get_child(index - 1)


func get_characters() -> Array[Character]:
	var output : Array[Character]
	for child in get_children(): if child is Character: output.append(child)
	return output
