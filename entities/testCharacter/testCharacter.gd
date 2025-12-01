class_name Character extends CharacterBody3D

var actionLock : int

var speedStrength : float
var target_direction: Vector2
var activeAbility : Ability_resource = null
var direction_indicator : Node3D
var preview : Preview
var active_ability_indicator: Sprite3D
var label_3d: Label3D

@export  var abilities : Array[Ability_resource]
@onready var visual : MeshInstance3D = $MeshInstance3D


func _ready() -> void:
	if self is not Preview: 
		direction_indicator = $DirectionIndicator
		preview = $preview
		active_ability_indicator = $ActiveAbilityIndicator
		label_3d = $Label3D



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

	var direction := (transform.basis * Vector3.FORWARD).normalized()
	if  direction:
		velocity.x = direction.x * activeAbility.MoveSpeed * speedStrength
		velocity.z = direction.z * activeAbility.MoveSpeed * speedStrength
	else:
		velocity.x = move_toward(velocity.x, 0, activeAbility.MoveSpeed * speedStrength)
		velocity.z = move_toward(velocity.z, 0, activeAbility.MoveSpeed * speedStrength)
 
	move_and_slide()


func select() -> void:
	direction_indicator.selected = true
	direction_indicator.visible = true
	preview.visual.mesh = visual.mesh
	preview.visible = true


func deselect() -> void:
	direction_indicator.selected = false
	direction_indicator.visible = false
	preview.visible = false

func set_active_ability(ability : Ability_resource) -> void:
	activeAbility = ability
	actionLock = ability.AnimationFrameLock
	label_3d.text = str(actionLock)
	active_ability_indicator.texture = ability.Icon
