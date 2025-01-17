class_name Bullet extends Sprite2D

@export var attri:Dictionary={
	"ap":0,
	"quantity":1,
	"atk_speed":0.0,
	"reload_cd":0.0,
}

func _on_bullet_area_body_entered(body: Node2D) -> void:
	if body is Player:
		body.bullet=self
		body.can_pick=true

func _on_bullet_area_body_exited(body: Node2D) -> void:
	if body is Player:
		body.can_pick=false
