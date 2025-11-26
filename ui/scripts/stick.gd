@icon("res://textures/stick.svg")

class_name Stick extends Control

var value: Vector2 = Vector2(0, 0)
var usable: bool = false
var margin: float = 0.8
var radius: float
var center: Vector2

@onready var base: TextureRect = $Base
@onready var knob: TextureRect = $Knob

signal valueChanged(value: Vector2)


func _process(_delta: float) -> void:
	# average for diameter then half for radius
	radius = min(size.x, size.y) / 2.0 * margin
	center = size * 0.5
	update_knob()


func _gui_input(event: InputEvent) -> void:
	if not usable:
		return

	if not is_within_base(get_local_mouse_position()):
		return

	if  event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		value = (get_local_mouse_position() / radius) - Vector2(1 / margin, 1 / margin)
		emit_signal("valueChanged", value)

	if  event is InputEventMouseMotion \
	and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		value = (get_local_mouse_position() / radius) - Vector2(1 / margin, 1 / margin)
		emit_signal("valueChanged", value)


#helpers
func is_within_base(pos: Vector2) -> bool:
	return (pos - center).length() <= (radius)


func update_knob() -> void:
	var knob_center_offset = knob.size / 2
	knob.position = (center + (value * radius)) - knob_center_offset


# getter en setter
func get_value() -> Vector2:
	return value


func set_values(dir: Vector2) -> void:
	value = dir


func character_changed(character: Character) -> void:
	if character:
		value = character.target_direction
