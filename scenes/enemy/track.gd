extends StateBase

func enter():
	pass

func exit() -> void:
	pass

func process_update(_delta: float) -> void:
	pass

func physical_process_update(delta: float) -> void:
	owner.velocity=owner.direction*owner.self_res.entity["speed"]*delta
	pass
