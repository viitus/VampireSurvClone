extends ColorRect

var mouse_over = false
var item = false
@onready var player = get_tree().get_first_node_in_group("jogador")

signal selected_upgrade(upgrade)


func _ready():
	connect("selected_upgrade", Callable(player, "upgrade_character"))

func _input(event):
	if event.is_action("click"):
		if mouse_over:
			emit_signal("selected_upgrade",item)


func _on_mouse_entered() -> void:
	mouse_over = true


func _on_mouse_exited() -> void:
	mouse_over = false
