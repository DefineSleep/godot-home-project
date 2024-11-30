extends PanelContainer


var save_path : String = "user://window2_position.cfg"
var is_dragging: bool = false
var drag_offset: Vector2

func _ready() -> void:
	set_process_input(true)
	load_position()
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and Input.is_key_pressed(KEY_CTRL) and Input.is_key_pressed(KEY_ALT):
			if event.pressed:
				if get_global_rect().has_point(get_global_mouse_position()):
					is_dragging = true
					drag_offset = get_global_mouse_position() - global_position
			else:
				is_dragging = false
	elif event is InputEventMouseMotion and is_dragging:
		global_position = get_global_mouse_position() - drag_offset

func save_position():
	var config = ConfigFile.new()
	config.set_value("window", "position_x", global_position.x)
	config.set_value("window", "position_y", global_position.y)
	config.save(save_path)

func load_position():
	var config = ConfigFile.new()
	if config.load(save_path) == OK:
		var pos_x = config.get_value("window", "position_x", global_position.x)
		var pos_y = config.get_value("window", "position_y", global_position.y)
		global_position = Vector2(pos_x,pos_y)
		


func _exit_tree() -> void:
	save_position()
