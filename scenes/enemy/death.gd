extends StateBase

const BULLET = preload("res://scenes/bullet/bullet.tscn")

func enter():
	get_tree().get_first_node_in_group("enemy_manager").enemy_quantity-=1
	#print(get_tree().get_first_node_in_group("enemy_manager").enemy_quantity)
	var t:Tween=create_tween()
	var bullet_ins=BULLET.instantiate()
	_match_bullet_type(bullet_ins)
	bullet_ins.position=owner.position
	owner.get_parent().add_child(bullet_ins)
	if owner.self_res.entity["name"]=="enemy1":
		NA.score+=2
		
	t.tween_property(owner,"modulate:a",0,0.2)
	t.tween_callback(owner.queue_free)
	pass

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	pass

func physical_process_update(delta: float) -> void:
	pass

func _match_bullet_type(bullet_ins:Node):
	match owner.bullet_type:
		"普通子弹":
				bullet_ins.attri={"name":"普通子弹",
				"ap":55,
				"max_quantity":5,
				"atk_speed":0.5,
				"reload_cd":1,
				"crit_rate":0.3,
				"crit_magnification":1.5,
				"hitted_cold":false,
				"boom_ap":0,
				"pic":preload("res://art/GGJ素材/子弹/bullet-2.png")}
		"冰霜子弹":
				bullet_ins.attri={"name":"冰霜子弹",
				"ap":60,
				"max_quantity":6,
				"atk_speed":0.2,
				"reload_cd":0.4,
				"crit_rate":0.3,
				"crit_magnification":1.5,
				"hitted_cold":true,
				"boom_ap":0,
				"pic":preload("res://art/GGJ素材/子弹/zidan-bingdong.png")}
		"爆炸子弹":
				bullet_ins.attri={"name":"爆炸子弹",
				"ap":0,
				"max_quantity":8,
				"atk_speed":0.4,
				"reload_cd":0.3,
				"crit_rate":0.5,
				"crit_magnification":2,
				"hitted_cold":false,
				"boom_ap":70,
				"pic":preload("res://art/GGJ素材/子弹/zidan-baozha.png")}
