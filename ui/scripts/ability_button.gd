class_name AbilityButton extends Button

var ability : Ability_resource

@onready var menu = get_owner()


func _init() -> void:
	flat = true
	icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
