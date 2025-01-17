extends CharacterBody2D

@export var  self_res:EntityAtrributes

var direction:Vector2

@onready var player:Player=get_tree().get_first_node_in_group("player")
@onready var health=self_res.entity["health"]
@onready var hurt_value: Label = $HurtValue

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		direction=(player.global_position-self.global_position).normalized()
		velocity=direction*self_res.entity["speed"]*delta
	
	#处理受击逻辑
	if self_res.entity["health"]!=health:
		velocity=-direction*self_res.entity["speed"]*delta
		print(self.name," ",str(self_res.entity["health"]))
		#显示文字
		hurt_value.text=str(health-self_res.entity["health"])
		#颜色改变
		var t:Tween=create_tween()
		t.tween_property(self,"modulate:a",0.1,0.1)
		t.tween_property(self,"modulate",Color(1,0.341,1,1),0.1)
		#判断死亡
		if self_res.entity["health"]<=0:
			on_death()
		#重置health
		health=self_res.entity["health"]
		
	move_and_slide()

func on_death():
	self.queue_free()
