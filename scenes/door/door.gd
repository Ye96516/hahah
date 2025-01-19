extends Area2D

##波数
@export var wave:int=3
##目标场景
@export var target_secene:PackedScene
##敌人最短生成时间
@export var min_spwan_time:float=1
##敌人最长生成时间
@export var max_spwan_time:float=4
##敌人最大生成数
@export var max_spwan_number:int=3
##是否沿x轴生成
@export var follow_x:bool
##x方向一半长度
@export var x_length:int=200
##y方向一半长度
@export var y_length:int=100
##巡逻路径
@export var path:Line2D
##是否可以生成
@export var can_spawn:bool
##生成哪种强度的敌人
@export_enum("1", "2", "3") var enemy_s: String="1"


var time:PackedFloat32Array
var number:int=0
var can_leave:bool
var is_first:bool=true

var enemy_wave:Array
var final_number:int

@onready var timer: Timer = $Timer
@onready var enemy:=preload("res://scenes/enemy/enemy.tscn")

func _ready() -> void:
	#随机生成三个时间点
	randomize()
	for i in wave:
		time.append(randf_range(min_spwan_time,max_spwan_time))
		var curr_number=randi_range(1,max_spwan_number)
		enemy_wave.append(curr_number)
		final_number+=curr_number


func _physics_process(delta: float) -> void:
	if can_spawn && is_first:
		timer.start()
		timer.wait_time=time[number]
		#根据时间点生成敌人
		timer.timeout.connect(func():
			randomize()
			#每波生成的敌人数
			for i in enemy_wave[number]:
				var enemy_ins:=enemy.instantiate()	
				match enemy_s:
					"1":
						var res1:=preload("res://scenes/enemy/data/enemy1.tres")
						res1.resource_local_to_scene=true
						enemy_ins.self_res=res1
					"2":
						var res2:=preload("res://scenes/enemy/data/enemy2.tres")
						res2.resource_local_to_scene=true
						enemy_ins.self_res=res2
					"3":
						var res3:=preload("res://scenes/enemy/data/enemy3.tres")
						res3.resource_local_to_scene=true
						enemy_ins.self_res=res3
				if get_parent() is EnemyManager:
					get_parent().enemys.append(enemy_ins)
					get_parent().enemy_quantity+=1
				print(enemy_ins.self_res.get_id())
				if follow_x:
					enemy_ins.position+=Vector2(randf_range(-x_length,x_length),0)
				else:
					enemy_ins.position+=Vector2(0,randf_range(-y_length,y_length))
				if is_instance_valid(path):
					enemy_ins.p1=path.points[0]
					enemy_ins.p2=path.points[1]
				add_child(enemy_ins)
				
			timer.wait_time=time[number]
			number+=1
			timer.start()
			if number==time.size():
				timer.stop()
			)
		is_first=false

func _on_body_entered(body: Node2D) -> void:
	if get_parent() is EnemyManager:
		if get_parent().enemy_quantity==0:
			can_leave=true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("change_scene") && can_leave:
		get_tree().change_scene_to_packed(target_secene)

func _on_body_exited(body: Node2D) -> void:
	can_leave=false
