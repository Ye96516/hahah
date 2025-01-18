extends StateBase
"""
此状态为shoot
"""
@onready var ray_cast_2d: RayCast2D = %RayCast2D
const WALK = preload("res://scenes/player/art/sound/walk.ogg")

func enter():
	pass

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	pass

func physical_process_update(delta: float) -> void:
	owner.velocity= owner.direction * owner.self_res.entity["speed"]*delta
	if owner.direction:
		AudioPlayer.play(WALK,true)
	pass
