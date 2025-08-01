extends Node

var score = 0

var special_item_found := false
signal special_item_collected

func _add_point():
	score += 1

signal player_died
