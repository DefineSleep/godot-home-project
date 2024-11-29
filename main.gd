extends Control



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

@onready var current_task: Label = $curent_task_container/current_task

@onready var date_label: Label = $date_label

@onready var incremental_timer: Timer = $incremental_timer

@onready var money_timer: Label = $incremental_timer/money_timer


# save system 
var game_data : Dictionary = {
	"money" : 0,
	
}


# -----
# Clock variables

var miliseconds : int
var seconds : int 
var minutes : int 
var hours : int
 
var standing : bool = false
# -----

# --------------------------------

func _ready() -> void:
	OS.alert("USE WINDOWS KEY + LEFT or RIGHT TO MOVE WINDOW","README")
	pass 



func _process(delta: float) -> void:
	time_label.text = Time.get_time_string_from_system()
	current_task_logic(Time.get_time_string_from_system())
	standing_counter_text.text = str(miliseconds)
	standing_counter_code()
	print_schedule(Time.get_datetime_dict_from_system(false).hour)
	test_function()

	current_task.text = print_schedule(Time.get_datetime_dict_from_system(false).hour)
	update_time_date()
	money_timer.text = str(game_data.money)

	
# --------------------------------

func test_function():
	# have all print functions here for testing
	#OS.get_locale() -> "en_us"
	#OS.get_granted_permissions() -> []
	#OS.get_distribution_name() -> "Windows"
	
	#printerr()
	pass

# --------------------------------

		

func update_time_date():
	var current_time : Dictionary = Time.get_datetime_dict_from_system()
	date_label.text = weekday_setter(current_time.weekday)
	#print(weekday_setter(current_time.weekday))
	
	pass
	
	

func weekday_setter(_weekday):
	match _weekday:
		1: return "Monday"
		2: return "Tuesday"
		3: return "Wednesday"
		4: return "Thursday"
		5: return "Friday"
		6: return "Saturday"
		7: return "Sunday"
		_: return "error"

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
	OS.shell_open("https://docs.godotengine.org/en/stable")


func _on_shortcut_button_2_pressed() -> void:
	OS.shell_open("https://youtube.com")
	#OS.shell_open("https://gmail.com")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_reset_button_pressed() -> void:
	miliseconds = 0
	seconds = 0
	minutes = 0
	hours = 0
	

func _on_update_timer_timeout() -> void:
	update_memory_labels()
	pass
	
# ------
# loading and saving 
# ------



func data_save():
	pass
	
	
	
	
	
	
	
	
	
	
	
	
func data_load():
	pass
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
# ------

func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true : 
		OS.low_processor_usage_mode = true
	if toggled_on == false : 
		OS.low_processor_usage_mode = false


# ------
# SCHEDULE N SHIT
# ------
# code a way to enter text and setup slots 
var slot_1 : String = "slot 1"
var slot_2 : String = "slot 2"
var slot_3 : String = "slot 3"
var slot_4 : String = "slot 4"


func print_schedule(_time): # tie to a timer of 60 seconds 
	var current_task : String 
	#scehdule 
	match _time:
		18:current_task = "Morning routine"
		19:current_task = "Freetime , Setup Slots"
		20:current_task = "Freetime , Coffee"
		21:current_task = slot_1
		22:current_task = slot_1
		23:current_task = "Freetime"
		0:current_task = "Workout"
		1:current_task = "Drawing"
		2:current_task = slot_2
		3:current_task = slot_2
		4:current_task = "Freetime"
		5:current_task = slot_3
		6:current_task = "Food / Freetime"
		7:current_task = slot_4 + "| Finish work"
		8:current_task = slot_4
		9:current_task = "Bedtime routine"
		10:current_task = "Sleep"
		11:current_task = "Sleep"
		12:current_task = "Sleep"
		13:current_task = "Sleep"
		14:current_task = "Sleep"
		15:current_task = "Sleep"
		16:current_task = "Sleep"
		17:current_task = "Sleep"
		
		
		
		
		_:current_task = "ERROR : undefined"
	
	
	return current_task
	


func _on_settings_button_pressed() -> void: # TODO : SETTINGS PAGE OPEN?
	pass 


func _on_incremental_timer_timeout() -> void: # INCREMENTAL SYSTEM , MONEY  ++ 
	game_data.money +=1
	data_save()
