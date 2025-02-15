class_name Player extends CharacterBody2D

@onready var ray_cast_2d: RayCast2D = %RayCast2D
@onready var state_machine: StateMachine = $StateMachine
@onready var bullet_quantity: Label = %BulletQuantity
@onready var show_node: Node2D = $Show
@onready var soda_can:  = %SodaCan
@onready var pause_menu:=preload("res://scenes/pause_menu/pause_menu.tscn")
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var health_bar: TextureProgressBar = %HealthBar
@onready var health:float=self_res.entity["health"]
@onready var health_bar_over: TextureRect = $CanvasLayer/HealthBarOver
@onready var icon: Sprite2D = $Show/Icon
@onready var count_down: Label = %CountDown
@onready var score: Label = %Score

@export var self_res:EntityAtrributes
@export var cout_time:float=60

const MAIN_CHARACTER = preload("res://art/GGJ素材/角色/MainCharacter.png")
const MAIN_CHARACTER_PIN = preload("res://art/GGJ素材/角色/MainCharacter-pin.png")
var direction:Vector2
var can_pick:bool
var bullet:Bullet
var is_first_scale_change:bool=true
var is_death:bool

func _ready() -> void:
	health_bar_over.material.set("shader_parameter/outline_width",0)
	health_bar.value= self_res.entity["health"]
	pass

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("move_left","move_right","move_top","move_down")
	move_and_slide()
	
	#拾取逻辑
	if Input.is_action_just_pressed("pick_up") &&can_pick:
		self_res.entity["ap"]=bullet.attri["ap"]
		self_res.entity["atk_speed"]=bullet.attri["atk_speed"]
		self_res.entity["reload_cd"]=bullet.attri["reload_cd"]
		self_res.entity["hitted_cold"]=bullet.attri["hitted_cold"]
		self_res.entity["crit_rate"]=bullet.attri["crit_rate"]
		self_res.entity["crit_magnification"]=bullet.attri["crit_magnification"]
		self_res.entity["boom_ap"]=bullet.attri["boom_ap"]
		self_res.entity["max_quantity"]=bullet.attri["max_quantity"]
		self_res.entity["quantity"]=self_res.entity["max_quantity"]
		bullet_quantity.text=str(self_res.entity["quantity"])
		bullet.queue_free()
	
	var mouse_pos:Vector2=get_viewport().get_mouse_position()
	var local_mouse_pos:Vector2=self.to_local(mouse_pos)
	if local_mouse_pos.x>0:
		handle_show_node_scale(false)
	else:
		handle_show_node_scale(true)
	
	_on_hurt()
	cout_time-=delta
	count_down.text="CountDown: "+str(int(cout_time))
	score.text="Score: "+str(NA.score)
	if cout_time<=0:
		get_tree().change_scene_to_file("res://scenes/start_menu/start_menu.tscn")

func handle_show_node_scale(is_flip:bool):
	if not is_flip && is_first_scale_change:
		show_node.scale.x=1
		soda_can.is_flip=false
		ray_cast_2d.is_flip=false
		is_first_scale_change=false
	elif is_flip && not is_first_scale_change:
		show_node.scale.x=-1
		soda_can.is_flip=true
		ray_cast_2d.is_flip=true
		is_first_scale_change=true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var pause_menu_ins:=pause_menu.instantiate()
		canvas_layer.call_deferred("add_child",pause_menu_ins)
		get_tree().paused=!get_tree().paused
	#加速
	if event.is_action_pressed("speed_up"):
		self_res.entity["speed"]*=2
	if event.is_action_released("speed_up"):
		self_res.entity["speed"]/=2
		
func _on_hurt():
	#处理受击逻辑
	if self_res.entity["health"]!=health:
		health=self_res.entity["health"]
		if self_res.entity["health"]<=30:
			health_bar_over.material.set("shader_parameter/outline_width",10)
		health_bar.value=self_res.entity["health"]
		icon.texture=MAIN_CHARACTER_PIN
		var timer:Timer=Timer.new()
		printt(self_res.entity["health"],health)
		add_child(timer)
		timer.wait_time=0.1
		timer.one_shot=true
		timer.start()
		timer.timeout.connect(
			func():
				icon.texture=MAIN_CHARACTER
				timer.queue_free()
		)
		
		#判断死亡
		if self_res.entity["health"]<=0 && not is_death:
			_on_death()
		#重置health
		

func _on_death():
	state_machine.change_state("Death")
	is_death=true
