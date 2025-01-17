class_name StateBase extends Node

@export var ans:AnimatedSprite2D
@export var an:AnimationPlayer

var state_machine: StateMachine

## 进入状态
func enter() -> void:
	pass

## 退出状态
func exit() -> void:
	pass

## 渲染帧触发
func process_update(_delta: float) -> void:
	pass

## 物理帧触发
func physical_process_update(_delta: float) -> void:
	pass
