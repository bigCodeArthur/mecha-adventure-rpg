extends Control

var usable = false
var active_touch_id: int = -1
var radius: float
var center: Vector2
var value: Vector2 = Vector2(0, 0)

@onready var base: TextureRect = $Base
@onready var knob: TextureRect = $Knob

signal valueChanged(value: Vector2)

#TODO: do not call this every frame dumbass
func _process(delta: float) -> void:
	# average for diameter then half for radius
	radius = ((size.x + size.y) / 2.0) / 2.0 
	center = Vector2(radius, radius)

func _gui_input(event: InputEvent) -> void:
	if not usable:
		return

	if not is_within_base(get_local_mouse_position()):
		return

	if  event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		value = (get_local_mouse_position() / radius) - Vector2(1, 1)
		update_knob()
		emit_signal("valueChanged", value)
		print(value)

	if  event is InputEventMouseMotion \
	and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		value = (get_local_mouse_position() / radius) - Vector2(1, 1)
		update_knob()
		emit_signal("valueChanged", value)
		print(value)

#helpers
func is_within_base(pos: Vector2) -> bool:
	return (pos - center).length() <= (radius)

func update_knob() -> void:
	var offset = knob.size / 2
	knob.position = (center + (value * radius)) - offset

# getter en setter
func get_value() -> Vector2:
	return value

func set_values(dir: Vector2) -> void:
	value = dir
	update_knob()
