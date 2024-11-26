extends Control

@onready var texture_rect: TextureRect = $TextureRect # background 

@onready var time_label: Label = $PanelContainer/time_label


@onready var standing_counter_text: Label = $standing_counter_container/HBoxContainer/standing_counter_text
@onready var standing_counter_button: CheckButton = $standing_counter_container/HBoxContainer/standing_counter_button

# memory usage
@onready var physical_mem: Label = $PanelContainer2/VBoxContainer/physical_mem
@onready var free_mem: Label = $PanelContainer2/VBoxContainer/free_mem
@onready var available_mem: Label = $PanelContainer2/VBoxContainer/available_mem
@onready var stack_meme: Label = $PanelContainer2/VBoxContainer/stack_meme


@onready var processor_name: Label = $HBoxContainer/processor_name
@onready var processor_cores: Label = $HBoxContainer/processor_cores




# save system 
var game_data = {
	
	
}


# -----
# Clock variables

var miliseconds : int
var seconds : int 
var minutes : int 
var hours : int
 
var standing : bool = false
# -----



func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	update_memory_labels()
	time_label.text = Time.get_time_string_from_system()
	current_task_logic(Time.get_time_string_from_system())
	standing_counter_text.text = str(miliseconds)
	standing_counter_code()

func update_memory_labels(): # percentage_full = (curreent_amount/max_amount) * 100 
	processor_name.text = OS.get_processor_name()
	processor_cores.text = str(OS.get_processor_count()) + "Threads"

	physical_mem.text = "Physical: "+str(OS.get_memory_info().physical)
	free_mem.text = "Free: "+str(OS.get_memory_info().free)
	available_mem.text = "Available: "+str(OS.get_memory_info().available)
	stack_meme.text = "Stack: "+str(OS.get_memory_info().stack)
	




func standing_counter_code():

	standing_counter_text.text = str(hours).pad_zeros(2) + ": " + str(minutes).pad_zeros(2) + ": " + str(seconds).pad_zeros(2) + ": " + str(miliseconds).pad_zeros(2)
	if standing:
		miliseconds += 1
		if miliseconds == 60:
			seconds += 1
			miliseconds = 0
		if seconds == 60:
			minutes += 1
			seconds = 0
		if minutes == 60:
			hours += 1
			minutes = 0
		



func _on_standing_counter_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true :
		standing = true
		
	if toggled_on == false :
		standing = false 

func current_task_logic(time):
	pass


func _on_shortcut_button_1_pressed() -> void:
	OS.shell_open("https://godotengine.org")


func _on_shortcut_button_2_pressed() -> void:
	OS.shell_open("https://youtube.com")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_reset_button_pressed() -> void:
	miliseconds = 0
	seconds = 0
	minutes = 0
	hours = 0
	
	
# ------
# loading and saving 
# ------
