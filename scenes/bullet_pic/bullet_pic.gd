extends Area2D

@export var speed:int=10000
@export var boom_ap:int=30

var dir:Vector2

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	self.global_position+=dir*speed*delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.queue_free()

func _on_bullet_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		$BulletPic.visible=false
