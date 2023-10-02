extends Node

const GROUPS = { PLAYER = "Player", ENEMY = "Enemy" }

var Lancelot := preload("res://compontents/units/azyrran.tres")
var Azyrran := preload("res://compontents/units/lancelot.tres")

var party:Array[Attributes] = [Lancelot, Azyrran]


func _input(event: InputEvent) -> void: if event.is_action_pressed("ui_cancel"): get_tree().quit()
