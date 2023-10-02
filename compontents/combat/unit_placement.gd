extends Marker2D

@export var x_offset := 40
@export var y_offset := 20
@export var scale_ratio:float = 1

var positions:Array[Vector2] = []

"""
amount_of_child_nodes
global_position
"""
func _ready() -> void:
	var pos := self.global_position
	
	var three_nodes_1 = Vector2(pos.x - x_offset, pos.y - y_offset)
	var three_nodes_3 = Vector2(pos.x + x_offset, pos.y - y_offset)
	
	var two_nodes_1 = Vector2(pos.x - roundi(x_offset / 2.0), pos.y)
	var two_nodes_2 = Vector2(pos.x + roundi(x_offset / 2.0), pos.y)
	
	positions = [pos,  three_nodes_3,three_nodes_1, two_nodes_1, two_nodes_2]
	
	

func _on_child_entered_tree(_node: Node) -> void:
	_recalculate_positions()

func _on_child_exiting_tree(_node: Node) -> void:
	_recalculate_positions()

func _recalculate_positions() -> void:
	await(get_tree().physics_frame)
	match self.get_child_count():
		1:
			var n = self.get_child(0)
			_interpolate_node_position(n, self.global_position, Vector2.ONE)
		2:
			var index = 3
			for n in self.get_children():
				var destination = positions[index]
				_interpolate_node_position(n, destination, Vector2.ONE)
				index += 1
		3:
			var index = 0
			for n in self.get_children():
				var destination = positions[index]
				_interpolate_node_position(n, destination, Vector2(scale_ratio,scale_ratio))
				index += 1

func _interpolate_node_position(n:Unit, pos:Vector2, scale_unit:Vector2) -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_parallel(true)
	tween.tween_property(n, "global_position", pos, 0.1)
	if(pos != self.global_position):
		tween.tween_property(n, "scale", scale_unit, 0.2).from_current()
