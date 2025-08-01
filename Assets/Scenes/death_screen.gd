extends CanvasLayer

func _ready():
	hide()
	Global.player_died.connect(_on_player_died)

func _on_player_died() -> void:
	show()
