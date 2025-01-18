extends Sprite2D

@export var speed:int=10000
var dir:Vector2

func _physics_process(delta: float) -> void:
	self.global_position+=dir*speed*delta
