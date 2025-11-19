extends CharacterBody3D

const weight = 1.0
const TURN_SPEED = 3.0
const SPEED = 3.0
const FORWARD: Vector3 = Vector3(0, 0, -1)
var speedStrength: float
var to: Vector2
var actionLock := 100

func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if to.length_squared() == 0:
		return

	var target_angle = to.normalized().angle() - PI / 2
	var unwrapped_angle = target_angle + rotation.y
	var delta_angle = wrapf(unwrapped_angle, -PI, PI)
	var max_step = TURN_SPEED * delta
	rotation.y += clamp(delta_angle, -max_step, max_step)

	var direction := (transform.basis * FORWARD).normalized()
	if direction:
		velocity.x = direction.x * SPEED * speedStrength
		velocity.z = direction.z * SPEED * speedStrength
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * speedStrength)
		velocity.z = move_toward(velocity.z, 0, SPEED * speedStrength)

	move_and_slide()
