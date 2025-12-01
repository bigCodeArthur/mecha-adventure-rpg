@icon("res://textures/abilities.svg")

class_name AbilitiesMenu extends Control

const BUTTON = preload("uid://bf0171xrtjenr")

@onready var abilities: HFlowContainer = $ScrollContainer/FlowContainer

signal abilityChanged(ability: Ability_resource)


func _ready() -> void:
	pass


func character_changed(character: Character) -> void:
	for child in abilities.get_children():
		child.queue_free()

	if not character:
		return

	for ability in character.abilities:
		var newButton = BUTTON.new(ability)
		newButton.pressed.connect(_changeAbility.bind(ability))
		abilities.add_child(newButton)

func _changeAbility(ability: Ability_resource) -> void:
	emit_signal("abilityChanged", ability)
