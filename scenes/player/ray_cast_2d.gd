extends RayCast2D

const SHOOT = preload("res://scenes/player/art/sound/shoot.ogg")
const EQUIP = preload("res://scenes/player/art/sound/Equip.ogg")
const SHOOT_LENGTH:int=3000
var one_shoot:bool
var is_flip:bool
var time:float
var cool_slow:bool

@onready var bullet_pic:=preload("res://scenes/bullet_pic/bullet_pic.tscn")
@onready var bullet_quantity: Label = %BulletQuantity
@onready var reload_cd: Timer = $"../ReloadCD"
@onready var soda_can:  = %"SodaCan"

func _ready() -> void:
	bullet_quantity.text=str(owner.self_res.entity["quantity"])

func _physics_process(delta: float) -> void:
	time+=delta
	#命中检测
	if self.is_colliding() && one_shoot:
		var collider=self.get_collider()
		if is_instance_valid(collider):
			if collider.is_in_group("enemy"):
				if owner.self_res.entity["hitted_cold"]:
					NA.bullet_effect("cold",collider.self_res)
				if owner.self_res.entity["boom_ap"]>0:
					%BoomArea.move(self.get_collision_point())
				else:
					var v:Array=NA.calculate_health(owner.self_res,collider.self_res)
					if v[1]:
						collider.get_node("HurtValue").modulate=Color.CORAL
					else:
						collider.get_node("HurtValue").modulate=Color(1,1,1)
				one_shoot=false

func _input(event: InputEvent) -> void:
	#主要的射击逻辑
	if time>=owner.self_res.entity["atk_speed"] && owner.self_res.entity["quantity"]>0:
		if event.is_action_pressed("shoot"):
			AudioPlayer.play(SHOOT)
			owner.self_res.entity["quantity"]-=1
			bullet_quantity.text=str("x",owner.self_res.entity["quantity"])
			raycast_shoot()
			time=0
			if owner.self_res.entity["quantity"]<=0:
				bullet_quantity.self_modulate=Color.CRIMSON
				AudioPlayer.play(EQUIP)
				if owner.self_res.entity["reload_cd"]>0:
					reload_cd.wait_time=owner.self_res.entity["reload_cd"]
					reload_cd.start()
					reload_cd.timeout.connect(func(): 
						owner.self_res.entity["quantity"]\
						=owner.self_res.entity["max_quantity"]
						bullet_quantity.self_modulate=Color(0,0,0,1)
						bullet_quantity.text=str("x",owner.self_res.entity["quantity"]) 
					)
				elif is_equal_approx(owner.self_res.entity["reload_cd"],0):
					owner.self_res.entity["quantity"]\
						=owner.self_res.entity["max_quantity"]
					bullet_quantity.self_modulate=Color(0,0,0,1)
					bullet_quantity.text=str("x",owner.self_res.entity["quantity"]) 

func raycast_shoot():
	one_shoot=true
	#获取鼠标本地坐标及子弹实例
	var mouse_pos:Vector2=get_viewport().get_mouse_position()
	var local_mouse_pos:Vector2=self.to_local(mouse_pos).normalized()
	var bp_ins:=bullet_pic.instantiate()
	#播放射击动画
	soda_can.shoot_anim()
	#设置子弹初始位置及翻转对应
	bp_ins.global_position=owner.global_position
	if not is_flip:
		bp_ins.dir=local_mouse_pos
	else:
		bp_ins.dir=Vector2(-local_mouse_pos.x,local_mouse_pos.y)

	owner.get_parent().call_deferred("add_child",bp_ins)
	self.target_position=local_mouse_pos*SHOOT_LENGTH
	#改变鼠标光标
	Input.set_custom_mouse_cursor(preload("res://art/GGJ素材/锚点/maodian1.png"),0,Vector2(56,56))
	await get_tree().create_timer(0.1).timeout
	Input.set_custom_mouse_cursor(preload("res://art/GGJ素材/锚点/maodian2.png"),0,Vector2(31,31))
