extends RayCast2D

@export var shoot_length:int=500

const SHOOT = preload("res://scenes/player/art/sound/shoot.ogg")
const EQUIP = preload("res://scenes/player/art/sound/Equip.ogg")
var one_shoot:bool
var is_flip:bool
var time:float

@onready var bullet_pic:=preload("res://scenes/bullet_pic/bullet_pic.tscn")
@onready var bullet_quantity: Label = %BulletQuantity
@onready var reload_cd: Timer = $"../ReloadCD"

func _ready() -> void:
	bullet_quantity.text=str(owner.self_res.entity["quantity"])

func _physics_process(delta: float) -> void:
	time+=delta
	if self.is_colliding() && one_shoot:
		var collider=self.get_collider()
		if is_instance_valid(collider):
			if collider.is_in_group("enemy"):
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
			bullet_quantity.text=str(owner.self_res.entity["quantity"])
			raycast_shoot()
			time=0
			if owner.self_res.entity["quantity"]<=0:
				AudioPlayer.play(EQUIP)
				if owner.self_res.entity["reload_cd"]>0:
					reload_cd.wait_time=owner.self_res.entity["reload_cd"]
					reload_cd.start()
					reload_cd.timeout.connect(func(): 
						owner.self_res.entity["quantity"]\
						=owner.self_res.entity["max_quantity"]
						bullet_quantity.text=str(owner.self_res.entity["quantity"]) 
					)
				elif is_equal_approx(owner.self_res.entity["reload_cd"],0):
					owner.self_res.entity["quantity"]\
						=owner.self_res.entity["max_quantity"]

func raycast_shoot():
	one_shoot=true
	var mouse_pos:Vector2=get_viewport().get_mouse_position()
	var local_mouse_pos:Vector2=self.to_local(mouse_pos).normalized()
	var bp_ins:=bullet_pic.instantiate()
	bp_ins.global_position=owner.global_position
	if not is_flip:
		bp_ins.dir=local_mouse_pos
	else:
		bp_ins.dir=Vector2(-local_mouse_pos.x,local_mouse_pos.y)
	owner.get_parent().call_deferred("add_child",bp_ins)
	self.target_position=local_mouse_pos*shoot_length
