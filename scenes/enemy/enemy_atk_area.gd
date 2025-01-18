extends Area2D

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time=owner.self_res.entity["atk_speed"]

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		timer.start()
		timer.timeout.connect(func():
			NA.calculate_health(owner.self_res,body.self_res)
			)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		timer.stop()
