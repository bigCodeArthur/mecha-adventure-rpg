@icon("res://textures/abilities.svg")

class_name AbilitiesMenu extends ScrollContainer

const button = preload("uid://bf0171xrtjenr")
@onready var abilities: HFlowContainer = $FlowContainer

signal abilityChanged(ability: Ability_resource)


func _ready() -> void:
	pass


func character_changed(character: Character) -> void:
	for child in abilities.get_children():
		child.free()

	if not character:
		return

	for ability in character.abilities:
		var newButton = button.new()
		newButton.icon = ability.Icon
		newButton.ability = ability
		newButton.text = ability.Name
		
		print(newButton.ability.Name)
		abilities.add_child(newButton)


func changeAbility(ability: Ability_resource) -> void:
	emit_signal("abilityChanged", ability)
