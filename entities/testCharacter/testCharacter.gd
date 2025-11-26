class_name Character extends CharacterBody3D

const FORWARD : Vector3 = Vector3(0, 0, -1)

var speedStrength : float
var target_direction: Vector2
var actionLock : int = 100
var activeAbility : Ability_resource = null

@export var abilities : Array[Ability_resource]

@onready var direction_indicator: Node3D = $DirectionIndicator

func _ready() -> void:
	activeAbility = abilities[0]

func _physics_process(delta: float) -> void:
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

	var direction := (transform.basis * FORWARD).normalized()

	if  direction:
		velocity.x = direction.x * activeAbility.MoveSpeed * speedStrength
		velocity.z = direction.z * activeAbility.MoveSpeed * speedStrength
	else:
		velocity.x = move_toward(velocity.x, 0, activeAbility.MoveSpeed * speedStrength)
		velocity.z = move_toward(velocity.z, 0, activeAbility.MoveSpeed * speedStrength)

	move_and_slide()


func select():
	direction_indicator.selected = true
	direction_indicator.visible = true


func deselect():
	direction_indicator.selected = false
	direction_indicator.visible = false
