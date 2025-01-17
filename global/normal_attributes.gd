extends Node

func calculate_health(attacker:EntityAtrributes,target:EntityAtrributes)->int:
	var final_atk=(attacker.entity["ap"]-target.entity["defense"])
	target.entity["health"]-=final_atk
	return target.entity["health"]
