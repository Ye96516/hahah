extends CharacterBody2D

signal enemy_death(node:CharacterBody2D)

@export var  self_res:EntityAtrributes
@export_enum ("普通子弹","爆炸子弹","减速子弹") var bullet_type:String="普通子弹"

const BULLET = preload("res://scenes/bullet/bullet.tscn")
const HURT = preload("res://scenes/player/art/sound/hurt.ogg")
var direction:Vector2
var is_death:bool
var p1:Vector2
var p2:Vector2
var is_cold:bool

@onready var player:Player=get_tree().get_first_node_in_group("player")
@onready var health=self_res.entity["health"]
@onready var hurt_value: Label = $HurtValue
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	self_res.resource_local_to_scene=true
	pass

func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		direction=(player.global_position-self.global_position).normalized()
	
	#处理受击逻辑
	if self_res.entity["health"]!=health:
		AudioPlayer.play(HURT)
		velocity=-direction*self_res.entity["speed"]*delta*2
		#显示文字

		hurt_value.text=str(health-self_res.entity["health"])
		animation_player.play("popup")
		#颜色改变
		var t:Tween=create_tween()
		t.tween_property(self,"modulate:a",0.1,0.1)
		t.tween_property(self,"modulate",Color(1,0.341,1,1),0.1)
		#判断死亡
		if self_res.entity["health"]<=0 && not is_death:
			on_death()
		#重置health
		health=self_res.entity["health"]
		
	move_and_slide()

func on_death():
	is_death=true
	get_tree().get_first_node_in_group("enemy_manager").enemy_quantity-=1
	#print(get_tree().get_first_node_in_group("enemy_manager").enemy_quantity)
	var t:Tween=create_tween()
	var bullet_ins=BULLET.instantiate()
	match bullet_type:
		"普通子弹":
				bullet_ins.attri={"name":"普通子弹",
				"ap":10,
				"max_quantity":5,
				"atk_speed":0.5,
				"reload_cd":1,
				"crit_rate":0.3,
				"crit_magnification":1.5,
				"hitted_cold":false,
				"boom_ap":0,}
		"冰霜子弹":
				bullet_ins.attri={"name":"冰霜子弹",
				"ap":15,
				"max_quantity":6,
				"atk_speed":0.4,
				"reload_cd":0.8,
				"crit_rate":0.3,
				"crit_magnification":1.5,
				"hitted_cold":true,
				"boom_ap":0,}
		"爆炸子弹":
				bullet_ins.attri={"name":"爆炸子弹",
				"ap":0,
				"max_quantity":8,
				"atk_speed":0.4,
				"reload_cd":0.8,
				"crit_rate":0.5,
				"crit_magnification":2,
				"hitted_cold":false,
				"boom_ap":20,}
	get_parent().add_child(bullet_ins)
	t.tween_property(self,"modulate:a",0,0.2)
	t.tween_callback(queue_free)
