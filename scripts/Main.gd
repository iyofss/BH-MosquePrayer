extends Control


# importing the time labels for the ui
@onready var fajr_countdown = $MarginContainer/VBoxContainer/PrayerTimingContainer/FajrContainer/TimeContainer/FajrCountdown
@onready var fajr_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/FajrContainer/TimeContainer/FajrTime
@onready var fajr_iqama_offset = $MarginContainer/VBoxContainer/PrayerTimingContainer/FajrContainer/TimeContainer/IqamaContainer/FajrIqamaOffset
@onready var fajr_iqama_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/FajrContainer/TimeContainer/IqamaContainer/FajrIqamaTime

@onready var sunrise_countdown = $MarginContainer/VBoxContainer/PrayerTimingContainer/SunriseContainer/TimeContainer/SunriseCountdown
@onready var sunrise_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/SunriseContainer/TimeContainer/SunriseTime
@onready var sunrise_iqama_offset = $MarginContainer/VBoxContainer/PrayerTimingContainer/SunriseContainer/TimeContainer/IqamaContainer/SunriseIqamaOffset
@onready var sunrise_iqama_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/SunriseContainer/TimeContainer/IqamaContainer/SunriseIqamaTime

@onready var dhuhr_countdown = $MarginContainer/VBoxContainer/PrayerTimingContainer/DhuhrContainer/TimeContainer/DhuhrCountdown
@onready var dhuhr_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/DhuhrContainer/TimeContainer/DhuhrTime
@onready var dhuhr_iqama_offset = $MarginContainer/VBoxContainer/PrayerTimingContainer/DhuhrContainer/TimeContainer/IqamaContainer/DhuhrIqamaOffset
@onready var dhuhr_iqama_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/DhuhrContainer/TimeContainer/IqamaContainer/DhuhrIqamaTime

@onready var asr_countdown = $MarginContainer/VBoxContainer/PrayerTimingContainer/AsrContainer/TimeContainer/AsrCountdown
@onready var asr_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/AsrContainer/TimeContainer/AsrTime
@onready var asr_iqama_offset = $MarginContainer/VBoxContainer/PrayerTimingContainer/AsrContainer/TimeContainer/IqamaContainer/AsrIqamaOffset
@onready var asr_iqama_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/AsrContainer/TimeContainer/IqamaContainer/AsrIqamaTime

@onready var maghrib_countdown = $MarginContainer/VBoxContainer/PrayerTimingContainer/MaghribContainer/TimeContainer/MaghribCountdown
@onready var maghrib_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/MaghribContainer/TimeContainer/MaghribTime
@onready var maghrib_iqama_offset = $MarginContainer/VBoxContainer/PrayerTimingContainer/MaghribContainer/TimeContainer/IqamaContainer/MaghribIqamaOffset
@onready var maghrib_iqama_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/MaghribContainer/TimeContainer/IqamaContainer/MaghribIqamaTime

@onready var isha_countdown = $MarginContainer/VBoxContainer/PrayerTimingContainer/IshaContainer/TimeContainer/IshaCountdown
@onready var isha_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/IshaContainer/TimeContainer/IshaTime
@onready var isha_iqama_offset = $MarginContainer/VBoxContainer/PrayerTimingContainer/IshaContainer/TimeContainer/IqamaContainer/IshaIqamaOffset
@onready var isha_iqama_time = $MarginContainer/VBoxContainer/PrayerTimingContainer/IshaContainer/TimeContainer/IqamaContainer/IshaIqamaTime

var fajr_time_json = 'null'
var sunrise_time_json = 'null'
var dhuhr_time_json = 'null'
var asr_time_json = 'null'
var maghrib_time_json = 'null'
var isha_time_json = 'null'


var date = '2024-07-28'
var PrayerTimeData = 'temp'
var IqamaTimeData = 'temp'

# Called when the node enters the scene tree for the first time.
func _ready():
	loadprayertime()
	#print(PrayerTimeData)

# this will check if the prayer time json exist and if so it will load it.
func loadprayertime():
# if the file does not exist it will run a func that will save it from github.
	if FileAccess.file_exists("res://data/prayer_timings_military_time.json"):
		var file = FileAccess.open("res://data/prayer_timings_military_time.json", FileAccess.READ)
		PrayerTimeData = JSON.parse_string(file.get_as_text())
		
		fajr_time_json = PrayerTimeData["prayerTime"][date]["fajr"]
		sunrise_time_json = PrayerTimeData["prayerTime"][date]["sunRiseTime"]
		dhuhr_time_json = PrayerTimeData["prayerTime"][date]["dhuhr"]
		asr_time_json = PrayerTimeData["prayerTime"][date]["asr"]
		maghrib_time_json = PrayerTimeData["prayerTime"][date]["maghrib"]
		isha_time_json = PrayerTimeData["prayerTime"][date]["isha"]
		
		setprayertimelabel()
	else:
		print('Missing Prayer Time Json, Will proceed to save it!')
		saveprayertime()

# this will request the prayer time json from github.
func saveprayertime():
	pass

# this will set the prayer time labels to the timings in the json file.
func setprayertimelabel():
	fajr_time.text = military_to_standard_time(fajr_time_json)
	fajr_iqama_offset.text = str(25)
	fajr_iqama_time.text = add_minutes_to_time(military_to_standard_time(fajr_time_json), 25)
	
	sunrise_time.text = military_to_standard_time(sunrise_time_json)
	
	dhuhr_time.text = military_to_standard_time(dhuhr_time_json)
	
	asr_time.text = military_to_standard_time(asr_time_json)
	
	maghrib_time.text = military_to_standard_time(maghrib_time_json)
	
	isha_time.text = military_to_standard_time(isha_time_json)
	

# this will take military time as input and will output standard time.
func military_to_standard_time(time_str: String) -> String:
	# Split the time string into its components
	var time_parts = time_str.split(":")
	var hour = int(time_parts[0])
	var minute = int(time_parts[1])

	# Determine the period (AM/PM)
	var period = " AM"
	if hour >= 12:
		period = " PM"
	if hour > 12:
		hour -= 12
	elif hour == 0:
		hour = 12

	# Format the time with leading zeroes if necessary
	var minute_str = str(minute)
	if minute < 10:
		minute_str = "0" + minute_str
	var hour_str = str(hour)
	if hour < 10:
		hour_str = "0" + hour_str
		
	# Format the new time string
	var new_time_str = hour_str + ":" + minute_str + period
	return new_time_str

# adds minutes to the time given, used to calculate the offset between the iqama and the azan.
func add_minutes_to_time(time_str: String, minutes: int) -> String:
	# Parse the time string
	var period = time_str.substr(time_str.length() - 2, 2).to_lower()
	var time_parts = time_str.substr(0, time_str.length() - 2).split(":")
	var hour = int(time_parts[0])
	var minute = int(time_parts[1])

	# Convert to 24-hour format
	if period == "PM" and hour != 12:
		hour += 12
	elif period == "AM" and hour == 12:
		hour = 0

	# Add the minutes
	minute += minutes

	# Adjust the hours and minutes
	hour += minute / 60
	minute = minute % 60
	hour = hour % 24

	# Convert back to 12-hour format
	var new_period = " AM"
	if hour >= 12:
		new_period = " PM"
	if hour > 12:
		hour -= 12
	elif hour == 0:
		hour = 12

	# Format the time with leading zeroes if necessary
	var minute_str = str(minute)
	if minute < 10:
		minute_str = "0" + minute_str
	var hour_str = str(hour)
	if hour < 10:
		hour_str = "0" + hour_str

	# Format the new time string
	var new_time_str = hour_str + ":" + minute_str + new_period
	return new_time_str
	

# this will handel setting the iqama time.


var main = 'memos'
var a = 22
var b = 45
var c = 10


func setiqamatime():
	var iqama_data = {
	mosque_name_text_edit.text: {
		"Fajr": fajr_iqama_text_edit.text,
		"Dhuhr": dhuhr_iqama_text_edit.text,
		"Asr": asr_iqama_text_edit.text,
		"Maghrib": maghrib_iqama_text_edit.text,
		"Isha": isha_iqama_text_edit.text,
	}
}

	var iqama_string = JSON.stringify(iqama_data, "\t")
	var file = FileAccess.open("res://data/iqama.json", FileAccess.WRITE)
	file.store_string(iqama_string)
	file.close()
	
	

@onready var color_rect = $MarginContainer/ColorRect
@onready var mosque_name_label = $MarginContainer/VBoxContainer/MosqueNameLabel
@onready var dhuhr_iqama_text_edit = $MarginContainer/ColorRect/VBoxContainer/HBoxContainer2/DhuhrIqamaTextEdit
@onready var fajr_iqama_text_edit = $MarginContainer/ColorRect/VBoxContainer/HBoxContainer/FajrIqamaTextEdit
@onready var asr_iqama_text_edit = $MarginContainer/ColorRect/VBoxContainer/HBoxContainer3/AsrIqamaTextEdit
@onready var maghrib_iqama_text_edit = $MarginContainer/ColorRect/VBoxContainer/HBoxContainer4/MaghribIqamaTextEdit
@onready var isha_iqama_text_edit = $MarginContainer/ColorRect/VBoxContainer/HBoxContainer5/IshaIqamaTextEdit
@onready var mosque_name_text_edit = $MarginContainer/ColorRect/VBoxContainer/VBoxContainer/MosqueNameTextEdit


func _on_back_iqama_button_2_pressed():
	color_rect.visible = false



func _on_set_iqama_button_pressed():
	color_rect.visible = true


func _on_apply_iqama_button_pressed():
	setiqamatime()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
