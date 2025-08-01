extends Node2D

@export var key0 : Texture2D
@export var key1 : Texture2D

@onready var key_icon: Sprite2D = $Key_Icon

func _ready():
	Global.special_item_collected.connect(update_icon)
	update_icon()

func update_icon():
	key_icon.texture = key1 if Global.special_item_found == true else key0
