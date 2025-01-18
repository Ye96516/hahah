extends Node

func calculate_health(attacker:EntityAtrributes,target:EntityAtrributes)->Array:
	var final_atk=(attacker.entity["ap"]-target.entity["defense"])
	var is_crit:bool
	if randf() <= attacker.entity["crit_rate"]:
		is_crit=true
		final_atk=(attacker.entity["ap"]*attacker.entity["crit_magnification"]-target.entity["defense"])
	target.entity["health"]-=final_atk
	return [target.entity["health"],is_crit]
