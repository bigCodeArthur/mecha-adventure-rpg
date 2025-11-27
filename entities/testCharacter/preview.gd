extends CharacterBody3D
@onready var main : Character = $".."
@onready var visual : MeshInstance3D = $MeshInstance3D

var activeAbility : Ability_resource
var target_direction : Vector2
var speedStrength : float

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
	frameToReset = main.activeAbility.AnimationFrameLock


func _physics_process(delta: float) -> void:
	if frame >= frameToReset:
		reset()
	else:
		frame += 1
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if not activeAbility:
		return

	if target_direction == Vector2.ZERO:
		return

	var target_angle = target_direction.normalized().angle() - PI / 2
	var angle_wrapped = wrapf(target_angle + rotation.y, -PI, PI)
	var smooth_step = activeAbility.TurnSpeed * delta
	rotation.y += clamp(angle_wrapped, -smooth_step, smooth_step)

	var direction := (transform.basis * Vector3.FORWARD).normalized()

	if  direction:
		velocity.x = direction.x * activeAbility.MoveSpeed * speedStrength
		velocity.z = direction.z * activeAbility.MoveSpeed * speedStrength
	else:
		velocity.x = move_toward(velocity.x, 0, activeAbility.MoveSpeed * speedStrength)
		velocity.z = move_toward(velocity.z, 0, activeAbility.MoveSpeed * speedStrength)

	move_and_slide()
