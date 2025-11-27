class_name AbilityButton extends Button

var ability : Ability_resource

@onready var menu = get_owner()


func _init(abilityInput : Ability_resource) -> void:
	flat = true
	icon_alignment = HORIZONTAL_ALIGNMENT_CENTER

	ability = abilityInput
	icon = abilityInput.Icon
	text = abilityInput.Name
