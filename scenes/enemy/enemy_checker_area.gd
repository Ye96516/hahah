extends Area2D

@onready var state_machine: StateMachine = $"../StateMachine"


func _on_body_entered(body: Node2D) -> void:
	state_machine.change_state("Track")
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	state_machine.change_state("Patrol")
	pass # Replace with function body.
