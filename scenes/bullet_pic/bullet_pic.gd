extends Sprite2D

@export var speed:int=10000
var dir:Vector2

func _physics_process(delta: float) -> void:
	self.global_position+=dir*speed*delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.queue_free()
