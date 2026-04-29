extends Control

func _on_graph_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Nodes/GraphTuringMaker/GraphTuringMaker.tscn")


func _on_base_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Nodes/BaseTuringMaker/BaseTuringMaker.tscn")


func _on_runner_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Nodes/TuringRunner/TuringRunner.tscn")
