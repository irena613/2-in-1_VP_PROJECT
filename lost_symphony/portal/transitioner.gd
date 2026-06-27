extends Control

class_name Transitoner

#idk how to fix this

@export var scene_switch_anim : String = "fade_out"
@export var scene_to_load : PackedScene 

@onready var animation_tex : TextureRect = $TextureRect
@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_tex.visible =false

#func set_next_animation(fading_out : bool):
	#if (fading_out):
		#animation_player.queue("fade_out")
	#else:
		#animation_player.queue("fade_in")
#
#
#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#if(scene_to_load != null && anim_name == scene_switch_anim):
		#get_tree().change_scene_to_packed(scene_to_load)
#
#
#func _on_portal_body_entered(body: Node2D) -> void:
	#if body == $Whalien:
		#set_next_animation(true)
