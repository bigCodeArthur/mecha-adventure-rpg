class_name PlayerUI extends Control

@export var stick: Stick
@export var abilities_menu: AbilitiesMenu
@export var battle_manager: BattleManager
@export var player: Player

var selectedCharacter : Character


func _on_stick_value_changed(value: Vector2) -> void:
	if  selectedCharacter:
		selectedCharacter.target_direction = value
		selectedCharacter.speedStrength = value.length()


func _on_abilities_menu_ability_changed(ability: Ability_resource) -> void:
	if  selectedCharacter:
		selectedCharacter.set_active_ability(ability)


func _on_player_character_changed(character: Character) -> void:
	selectedCharacter = character
	stick.character_changed(character)
	abilities_menu.character_changed(character)

func PLAY() -> void:
	battle_manager.PLAY()
