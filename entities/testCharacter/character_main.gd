class_name Character_main extends Character

@onready var direction_indicator = $DirectionIndicator
@onready var preview = $preview
@onready var active_ability_indicator = $ActiveAbilityIndicator
@onready var label_3d = $Label3D

func select() -> void:
	direction_indicator.selected = true
	direction_indicator.visible  = true
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
