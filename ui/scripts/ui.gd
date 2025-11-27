class_name PlayerUI extends Control

@onready var stick: Stick = $Stick
@onready var abilities_menu: AbilitiesMenu = $AbilitiesMenu

var selectedCharacter : Character


func _on_stick_value_changed(value: Vector2) -> void:
	if  selectedCharacter:
		selectedCharacter.target_direction = value
		selectedCharacter.speedStrength = value.length()


func _on_abilities_menu_ability_changed(ability: Ability_resource) -> void:
	if  selectedCharacter:
		selectedCharacter.activeAbility = ability


func _on_player_character_changed(character: Character) -> void:
	selectedCharacter = character
	stick.character_changed(character)
	abilities_menu.character_changed(character)
