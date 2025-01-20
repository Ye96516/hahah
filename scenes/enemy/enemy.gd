extends CharacterBody2D

signal enemy_death(node:CharacterBody2D)

@export var  self_res:EntityAtrributes
@export_enum ("普通子弹","爆炸子弹","减速子弹") var bullet_type:String="普通子弹"

const HURT = preload("res://scenes/player/art/sound/hurt.ogg")
var direction:Vector2
var is_death:bool
var p1:Vector2
var p2:Vector2
var is_cold:bool
var current_enemy:String="enemy1"
var health:float

@onready var player:Player=get_tree().get_first_node_in_group("player")
@onready var hurt_value: Label = $HurtValue
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_bar: TextureProgressBar = %HealthBar
@onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
@onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
	choose_enemy()
	randomize()
	var number:int=randi_range(1,3)
	if number==1:
		bullet_type="普通子弹"
	elif number==2:
		bullet_type="冰霜子弹"
	elif number==3:
		bullet_type="爆炸子弹"
	health=self_res.entity["health"]
	health_bar.max_value=self_res.entity["health"]
	health_bar.value=self_res.entity["health"]
	self_res.resource_local_to_scene=true
	pass

func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		direction=(player.global_position-self.global_position).normalized()
	
	#处理受击逻辑
	if self_res.entity["health"]!=health:
		#播放音效
		AudioPlayer.play(HURT)
		#击退
		velocity=-direction*self_res.entity["speed"]*delta*2
		#血量条显示
		health_bar.value=self_res.entity["health"]
		#显示文字
		hurt_value.text=str(health-self_res.entity["health"])
		animation_player_2.play("popup")
		animation_player.play("hurt")
		#颜色改变

		#判断死亡
		if self_res.entity["health"]<=0 && not is_death:
			state_machine.change_state("Death")
		#重置health
		health=self_res.entity["health"]
		
	move_and_slide()

func on_death():
	is_death=true


func choose_enemy():
	match current_enemy:
		"enemy1":
			self_res.entity={
			"name"="enemy1",
			"speed"=8000,
			"health"=100,
			"ap"=5,
			"shoot_length"=500,
			"crit_rate"=0.1,
			"crit_magnification"=1.2,
			"max_quantity"=1,
			"quantity"=1,
			"defense"=0,
			"atk_speed"=1.5,
			"reload_cd"=0.5,
			"boom_ap"=0,
			"hitted_boom"=false,
			"hitted_cold"=false,
			"is_cold"=false,
			"cold_time"=1.0,
		}
		"enemy2":
			self_res.entity={
			"name"="enemy2",
			"speed"=10000,
			"health"=300,
			"ap"=8,
			"shoot_length"=500,
			"crit_rate"=0.2,
			"crit_magnification"=1.3,
			"max_quantity"=1,
			"quantity"=1,
			"defense"=0,
			"atk_speed"=1.2,
			"reload_cd"=0.5,
			"boom_ap"=0,
			"hitted_boom"=false,
			"hitted_cold"=false,
			"is_cold"=false,
			"cold_time"=1.0,
		}
		"enemy3":
			self_res.entity={
			"name"="enemy3",
			"speed"=14000,
			"health"=500,
			"ap"=14,
			"shoot_length"=500,
			"crit_rate"=0.3,
			"crit_magnification"=1.5,
			"max_quantity"=1,
			"quantity"=1,
			"defense"=0,
			"atk_speed"=0.7,
			"reload_cd"=0.5,
			"boom_ap"=0,
			"hitted_boom"=false,
			"hitted_cold"=false,
			"is_cold"=false,
			"cold_time"=1.0,
		}
