extends Node

func calculate_health(attacker:EntityAtrributes,target:EntityAtrributes)->Array:
	var final_atk=(attacker.entity["ap"]-target.entity["defense"])
	var is_crit:bool
	if randf() <= attacker.entity["crit_rate"]:
		is_crit=true
		final_atk=(attacker.entity["ap"]*attacker.entity["crit_magnification"]-target.entity["defense"])
	target.entity["health"]-=final_atk
	return [target.entity["health"],is_crit]

func bullet_effect(e:String,target:EntityAtrributes):
	if e=="cold" && not target.entity["is_cold"]:
		target.entity["speed"]/=2
		target.entity["is_cold"]=true
		var timer:Timer=Timer.new()
		add_child(timer)
		timer.wait_time=target.entity["cold_time"]
		timer.start()
		timer.timeout.connect(func():
			target.entity["is_cold"]=false
			target.entity["speed"]*=2
			timer.queue_free()
			)
