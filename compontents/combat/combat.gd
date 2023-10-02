extends Node2D

const Unit_Scene := preload("res://compontents/units/unit.tscn")
@export var enemies:Array[Attributes] = []
@onready var player_origin = $PlayerPosition
@onready var enemy_origin = $EnemyPosition

var turn_queue:Array[Unit]

""" DEBUG - REMOVE LATER! """
var attr := load("res://compontents/units/witch.tres")
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_down")):
		var enemy_instance = _build_unit_instance(attr)
		enemy_origin.add_child(enemy_instance)
	
	if(event.is_action_pressed("ui_up")):
		turn_queue.pop_back().queue_free()

func _ready() -> void:
	for attrib in Global.party:
		var player_instance = _build_unit_instance(attrib)
		player_instance.add_to_group(Global.GROUPS.PLAYER)
		player_instance.hide()
		player_origin.add_child(player_instance)
		
	
	for attrib in enemies:
		var enemy_instance = _build_unit_instance(attrib)
		enemy_instance.add_to_group(Global.GROUPS.ENEMY)
		enemy_origin.add_child(enemy_instance)
	
	turn_queue.sort_custom(func(a:Unit,b:Unit): return a.attributes.initiative > b.attributes.initiative)
	
	TurnManager.player_turn_started.connect(_on_player_turn_started)
	TurnManager.enemy_turn_started.connect(_on_enemy_turn_started)
	
	if(turn_queue.pop_front().is_in_group(Global.GROUPS.PLAYER)):
		TurnManager._set_active_turn(TurnManager.Turn.PLAYER_TURN)
	else:
		TurnManager._set_active_turn(TurnManager.Turn.ENEMY_TURN)

func _build_unit_instance(attributes:Attributes) -> Unit:
	var unit := Unit_Scene.instantiate()
	unit.set_attributes(attributes)
	turn_queue.append(unit)
	
	return unit

func _on_player_turn_started() -> void:
	pass

func _on_enemy_turn_started() -> void:
	pass
