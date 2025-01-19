extends Area2D

@onready var pop: Sprite2D = $Pop

func _ready() -> void:
	pop.visible=false
	self.monitoring=false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.self_res.entity["health"]-=owner.self_res.entity["boom_ap"]
		
func move(pos:Vector2):
	self.global_position=pos
	self.monitoring=true
	pop.visible=true
	await get_tree().create_timer(0.2).timeout
	self.monitoring=false
	pop.visible=false
