extends Node2D

func _process(delta):
    if OS.is_window_maximized() == false:
        OS.set_window_maximized(true)