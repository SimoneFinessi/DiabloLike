class_name Weapon
extends Node2D


@export var attack_damage: int 
@export var attack_cooldown: float 

var can_attack: bool = true
var player:CharacterBody2D
func _ready():
	player=get_tree().current_scene.get_node("Player")
func attack(direction: Vector2) -> void:
	pass
