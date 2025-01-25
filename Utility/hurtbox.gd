extends Area2D

@export_enum("Cooldown","HitOnce","DisableHitBox") var HurtboxType = 0

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("attack"):
		if area.has_method("get") and not area.get("damage") == null:
			
			match HurtboxType:
				0: #Cooldown
					collision.call_deferred("set","disabled",true)
					disableTimer.start()
				1: #hitondce
					pass
				2: #Disablehitbox
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			emit_signal("hurt",damage)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)

func _on_disable_timer_timeout() -> void:
	collision.call_deferred("set","disabled",false)
