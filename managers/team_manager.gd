class_name TeamManager extends Node3D

var teams : Array[Team] = get_teams()
var allCharacters : Array[Character] = get_all_characters()


func get_teams() -> Array[Team]:
	var output : Array[Team]

	for child in get_children():
		if child is Team:
			output.append(child)

	return output


func get_all_characters() -> Array[Character]:
	var output : Array[Character]

	for team in get_teams():
		if team is Team:
			output.append_array(team.get_characters())

	return output

func get_player_team() -> Team:
	return get_teams()[0]
