extends Area2D

@export_enum("Cooldown","HitOnce","DisableHitBox") var HurtboxType = 0

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(damage, angle, knockback)

var hitonce_array = []

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("attack"):
		if area.has_method("get") and not area.get("damage") == null:
			
			match HurtboxType:
				0: #Cooldown
					collision.call_deferred("set","disabled",true)
					disableTimer.start()
				1: #hitondce
					if hitonce_array.has(area) == false:
						hitonce_array.append(area)
						if area.has_signal("remove_from_array"):
							if not area.is_connected("remove_from_array",Callable(self,"remove_from_list")):
								area.connect("remove_from_array",Callable(self,"remove_from_list"))
					else:
						return
				2: #Disablehitbox
					if area.has_method("tempdisable"):
						area.tempdisable()
			var damage = area.damage
			var angle = Vector2.ZERO
			var knockback = 1
			if not area.get("angle") == null:
				angle = area.angle
			if not area.get("knockback_amount") == null:
				knockback = area.knockback_amount
			
			emit_signal("hurt",damage, angle, knockback)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)

func remove_from_list(object):
	if hitonce_array.has(object):
		hitonce_array.erase(object)

func _on_disable_timer_timeout() -> void:
	collision.call_deferred("set","disabled",false)
