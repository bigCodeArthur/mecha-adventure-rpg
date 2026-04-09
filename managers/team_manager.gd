class_name TeamManager extends Node3D
## TeamManager.
##
## parent of all teams in the scene tree. 

## The description of the variable.
var teams : Array[Team] = get_teams()
## The description of the variable.
var allCharacters : Array[Character_main] = get_all_characters()

## The description of the Method.
func get_teams() -> Array[Team]:
	var output : Array[Team]
	for child in get_children(): if child is Team: output.append(child)
	return output

## The description of the Method.
func get_all_characters() -> Array[Character_main]:
	var output : Array[Character_main]
	for team in get_teams(): if team is Team: output.append_array(team.get_characters())
	return output

## The description of the Method.
func get_player_team() -> Team:
	return get_teams()[0]
