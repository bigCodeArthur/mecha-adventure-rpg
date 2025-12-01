class_name Preview extends Character
@onready var main : Character = $".."

var frameToReset : int
var frame : int = 0

func reset() -> void:
	position = Vector3.ZERO
	rotation = main.rotation
	velocity = main.velocity

	activeAbility = main.activeAbility
	target_direction = main.target_direction
	speedStrength = main.speedStrength

	frame = 0
	if activeAbility:
		frameToReset = activeAbility.AnimationFrameLock


func _physics_process(delta: float) -> void:
	if frame >= frameToReset:
		reset()
	else:
		frame += 1

	super._physics_process(delta)

func select():
	pass
