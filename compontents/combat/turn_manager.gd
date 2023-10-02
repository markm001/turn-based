extends Node

enum Turn {PLAYER_TURN, ENEMY_TURN}

var active_turn:Turn : set = _set_active_turn

signal player_turn_started
signal enemy_turn_started


func _set_active_turn(value:Turn) -> void:
	active_turn = value
	
	if active_turn == Turn.PLAYER_TURN:
		player_turn_started.emit()
	else:
		enemy_turn_started.emit()
