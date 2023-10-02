class_name Unit extends Node2D

@export var attributes:Attributes:set=set_attributes, get=get_attributes
var animations:AnimatedSprite2D

func set_attributes(attrib:Attributes)->void:
	attributes = attrib
	animations = attributes.animations.instantiate()
	self.add_child(animations)

func get_attributes()-> Attributes:
	return attributes
