extends Node3D
@onready var ui: Control = $"../../../UI"
@onready var battleZone: Node3D = $"../../.."
@onready var characters: Node3D = $"../.."
@onready var myTeam : Node3D = $".."
@onready var body: CharacterBody3D = $testCharacterBody
@onready var teams: Array[Node] = characters.get_children()
