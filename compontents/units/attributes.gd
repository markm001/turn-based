class_name Attributes extends Resource

signal health_depleted
signal health_changed
signal max_health_changed
signal level_changed

@export var name:String
@export var max_health := 10 : set=set_max_health
@export var initiative := 10

@export var class_icon: AtlasTexture
@export var image: PackedScene
@export var animations: PackedScene
@export var commands:Array[Command]

var level := 1
var health:int : set=set_health

func set_max_health(value:int) -> void:
	max_health = value
	health = max_health
	max_health_changed.emit()

func set_health(value:int) -> void:
	health = clamp(value, 0, max_health)
	health_changed.emit()
	if(health <= 0): health_depleted.emit()
