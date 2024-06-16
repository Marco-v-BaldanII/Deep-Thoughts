extends Control




func _on_start_pressed():
	get_tree().change_scene_to_file("res://Pau/cinematica1.tscn")

func _on_controls_button_down():
	get_tree().change_scene_to_file("res://Marco/obstacles/Controls.tscn")

func _on_quit_button_down():
	get_tree().quit()

 


func _on_button_button_down():
	get_tree().change_scene_to_file("res://Marco/creditsnew.tscn")


func _on_starttxt_button_down():
	get_tree().change_scene_to_file("res://Pau/cinematica1.tscn")


func _on_controlstxt_button_down():
	get_tree().change_scene_to_file("res://Marco/obstacles/Controls.tscn")


func _on_creditstxt_button_down():
	get_tree().change_scene_to_file("res://Marco/creditsnew.tscn")


func _on_quittxt_button_down():
	get_tree().quit()
