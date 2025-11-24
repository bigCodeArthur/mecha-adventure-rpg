extends CharacterBody3D

const weight = 1.0
const TURN_SPEED = 3.0
const SPEED = 3.0
const FORWARD: Vector3 = Vector3(0, 0, -1)

var speedStrength: float
var target_direction: Vector2
var actionLock := 100

@onready var direction_indicator: Node3D = $DirectionIndicator

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if target_direction == Vector2.ZERO:
		return

	var target_angle = target_direction.normalized().angle() - PI / 2
	var angle_wrapped = wrapf(target_angle + rotation.y, -PI, PI)
	var smooth_step = TURN_SPEED * delta
	rotation.y += clamp(angle_wrapped, -smooth_step, smooth_step)

	var direction := (transform.basis * FORWARD).normalized()
	if direction:
		velocity.x = direction.x * SPEED * speedStrength
		velocity.z = direction.z * SPEED * speedStrength
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * speedStrength)
		velocity.z = move_toward(velocity.z, 0, SPEED * speedStrength)

	move_and_slide()


func select():
	direction_indicator.selected = true
	direction_indicator.visible = true


func deselect():
	direction_indicator.selected = false
	direction_indicator.visible = false
