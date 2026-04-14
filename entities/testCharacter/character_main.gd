class_name Character_main extends Character
## test descriptie.
##
## parent of all teams in the scene tree.

@onready var team = $".."
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
	if not ability:
		activeAbility = null
		actionLock = 0
		active_ability_indicator.texture = null
	else:
		activeAbility = ability
		actionLock = ability.AnimationFrameLock
		active_ability_indicator.texture = ability.Icon
