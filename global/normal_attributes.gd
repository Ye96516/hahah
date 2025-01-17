extends Node

signal entity_death(entity_name:String)

var player:Dictionary={
	"name"="player",
	"speed"=30000,
	"health"=100,
	"ap"=10,
	"defense"=0,
	"atk_speed"=1,
}

var enemy:Dictionary={
	"name"="enemy",
	"speed"=10000,
	"health"=100,
	"ap"=100,
	"defense"=0,
	"atk_speed"=1,
}

func calculate_health(attacker:String,target:String)->int:
	match attacker:
		"player":
			if target=="enemy":
				return _calculate_detail(player,enemy)
		"enemy":
			if target=="player":
				return _calculate_detail(enemy,player)
		_:
			printerr("攻击方与受击方不匹配")
			return 0
	return 0
	
func _calculate_detail(atker:Dictionary,tg:Dictionary)->int:
	tg["health"]-=atker["ap"]-tg["defense"]
	print(tg.name," ",tg.health)
	if tg["health"]<=0:
		entity_death.emit(tg["name"])
	return tg["health"]
