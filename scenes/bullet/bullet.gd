class_name Bullet extends Sprite2D

@export var attri:Dictionary={
	"name":"",
	"ap":0,
	"max_quantity":1,
	"atk_speed":0.0,
	"reload_cd":0.0,
	"crit_rate":0.0,
	"crit_magnification":1.0,
	"hitted_cold":false,
	"boom_ap":0,
	"pic":preload("res://art/GGJ素材/子弹/bullet-2.png"),
	
}
@onready var panel_container: PanelContainer = $CanvasLayer/PanelContainer

func _ready() -> void:
	self.texture=attri["pic"]
	
func _on_bullet_area_body_entered(body: Node2D) -> void:
	if body is Player:
		body.bullet=self
		body.can_pick=true
		panel_container.visible=true

func _on_bullet_area_body_exited(body: Node2D) -> void:
	if body is Player:
		body.can_pick=false
		panel_container.visible=false
