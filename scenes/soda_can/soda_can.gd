extends Area2D

var is_flip:bool
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	$SodaCan/Penshe.visible=false

func _process(delta: float) -> void:
	# 获取鼠标在世界空间中的位置
	var mouse_position:Vector2 = get_global_mouse_position()
	
	# 计算武器到鼠标的方向向量
	var direction:Vector2 = mouse_position - self.global_position
	
	# 计算旋转角度（以弧度表示）
	var angle:float
	if is_flip:
		angle=-direction.angle()
		self.scale.x=-1
	else:
		angle=direction.angle()
		self.scale.x=1
	# 设置武器的旋转角度
	self.rotation = angle

func shoot_anim():
	animation_player.play("shoot")

func shoot_anim_2():
	print("shoot_2")
	animation_player.play("shoot_2")
