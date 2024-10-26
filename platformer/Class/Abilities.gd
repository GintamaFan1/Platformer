extends Node

class_name Ability


@export var target_tile: Tile

func _ready() -> void:
	add_to_group("abilities")

func activate(tile: Tile):
	pass
