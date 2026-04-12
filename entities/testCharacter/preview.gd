class_name Preview extends Character

@onready var main : Character_main = $".."

var frameToReset : int


func reset() -> void:
	position = Vector3.ZERO
	rotation = main.rotation
	velocity = main.velocity

	activeAbility    = main.activeAbility
	target_direction = main.target_direction
	speedStrength    = main.speedStrength

	if activeAbility: actionLock = activeAbility.AnimationFrameLock
	frameToReset = 0


func _physics_process(delta: float) -> void:
	if actionLock <= 0: reset()
	else: actionLock -= 1
	super(delta)
