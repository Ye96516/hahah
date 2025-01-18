extends Sprite2D

var is_flip:bool

func _process(delta: float) -> void:
	# 获取鼠标在世界空间中的位置
	var mouse_position:Vector2 = get_global_mouse_position()
	
	# 计算武器到鼠标的方向向量
	var direction:Vector2 = mouse_position - self.global_position
	
	# 计算旋转角度（以弧度表示）
	var angle:float
	if is_flip:
		angle=-direction.angle()
	else:
		angle=direction.angle()
	
	# 设置武器的旋转角度
	self.rotation = angle
