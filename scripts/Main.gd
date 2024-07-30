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

@onready var color_rect = $MarginContainer/ColorRect
@onready var mosque_name_label = $MarginContainer/VBoxContainer/MosqueNameLabel
@onready var dhuhr_iqama_text_edit = $MarginContainer/ColorRect/VBoxContainer/HBoxContainer2/DhuhrIqamaTextEdit
@onready var fajr_iqama_text_edit = $MarginContainer/ColorRect/VBoxContainer/HBoxContainer/FajrIqamaTextEdit
@onready var asr_iqama_text_edit = $MarginContainer/ColorRect/VBoxContainer/HBoxContainer3/AsrIqamaTextEdit
@onready var maghrib_iqama_text_edit = $MarginContainer/ColorRect/VBoxContainer/HBoxContainer4/MaghribIqamaTextEdit
@onready var isha_iqama_text_edit = $MarginContainer/ColorRect/VBoxContainer/HBoxContainer5/IshaIqamaTextEdit
@onready var mosque_name_text_edit = $MarginContainer/ColorRect/VBoxContainer/VBoxContainer/MosqueNameTextEdit

@onready var date_label = $MarginContainer/VBoxContainer/dateLabel


var fajr_time_json = 'null'
var sunrise_time_json = 'null'
var dhuhr_time_json = 'null'
var asr_time_json = 'null'
var maghrib_time_json = 'null'
var isha_time_json = 'null'

var fajr_iqama_offset_json = '0'
var dhuhr_iqama_offset_json = '0'
var asr_iqama_offset_json = '0'
var maghrib_iqama_offset_json = '0'
var isha_iqama_offset_json = '0'
var mosque_name_json = ''


var date = '2024-07-28'
var PrayerTimeData = 'temp'
var IqamaTimeData = 'temp'
var currentTime = ''
# Called when the node enters the scene tree for the first time.
func _ready():
	currentTime = Time.get_datetime_dict_from_system()
	

	
	print(currentTime)
	print(calculate_countdown("14:30" + ":00", "16:40" + ":00"))
	setiqamacountdownoffset()
	loadprayertime()
	#print(PrayerTimeData)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currentTime = Time.get_datetime_dict_from_system()
	#var currentYear = currentTime['year']
	date = Time.get_date_string_from_system()
	#print(date)
	loadprayertime()

func calculate_countdown(time_a: String, time_b: String) -> String:
	# Split the time strings into hours, minutes, and seconds
	var time_a_split = time_a.split(":")
	var time_b_split = time_b.split(":")
	
	# Convert split values to integers
	var hour_a = int(time_a_split[0])
	var minute_a = int(time_a_split[1])
	var second_a = int(time_a_split[2])
	
	var hour_b = int(time_b_split[0])
	var minute_b = int(time_b_split[1])
	var second_b = int(time_b_split[2])
	
	# Calculate total seconds from the start of the day for each time
	var total_seconds_a = hour_a * 3600 + minute_a * 60 + second_a
	var total_seconds_b = hour_b * 3600 + minute_b * 60 + second_b
	
	# Calculate the absolute difference in seconds between the two times
	var countdown_seconds = abs(total_seconds_b - total_seconds_a)
	
	# Convert the countdown seconds back into hours, minutes, and seconds
	var hours = countdown_seconds / 3600
	countdown_seconds %= 3600
	var minutes = countdown_seconds / 60
	countdown_seconds %= 60
	var seconds = countdown_seconds
	
	# Format the result as HH:MM:SS and return
	return pad_zero(hours) + ":" + pad_zero(minutes)
	#return pad_zero(hours) + ":" + pad_zero(minutes) + ":" + pad_zero(seconds)
# Custom function to pad a number with zeroes to ensure two digits
func pad_zero(value: int) -> String:
	if value < 10:
		return "0" + str(value)
	return str(value)

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
		
		fajr_iqama_time.text = add_minutes_to_time(military_to_standard_time(fajr_time_json), int(fajr_iqama_offset_json))
		dhuhr_iqama_time.text = add_minutes_to_time(military_to_standard_time(dhuhr_time_json), int(dhuhr_iqama_offset_json))
		asr_iqama_time.text = add_minutes_to_time(military_to_standard_time(asr_time_json), int(asr_iqama_offset_json))
		maghrib_iqama_time.text = add_minutes_to_time(military_to_standard_time(maghrib_time_json), int(maghrib_iqama_offset_json))
		isha_iqama_time.text = add_minutes_to_time(military_to_standard_time(isha_time_json), int(isha_iqama_offset_json))
		
		setprayertimelabel()
	else:
		print('Missing Prayer Time Json, Will proceed to save it!')
		saveprayertime()

# this will request the prayer time json from github.
func saveprayertime():
	pass

# this is resposible for the label changing of the iqama countdown, offset and mosque name.
func setiqamacountdownoffset():
	if FileAccess.file_exists("res://data/iqama.json"):
		var file = FileAccess.open("res://data/iqama.json", FileAccess.READ)
		IqamaTimeData = JSON.parse_string(file.get_as_text())
		
		fajr_iqama_offset_json = IqamaTimeData["IqamaOffset"]["Fajr"]
		dhuhr_iqama_offset_json = IqamaTimeData["IqamaOffset"]["Dhuhr"]
		asr_iqama_offset_json = IqamaTimeData["IqamaOffset"]["Asr"]
		maghrib_iqama_offset_json = IqamaTimeData["IqamaOffset"]["Maghrib"]
		isha_iqama_offset_json = IqamaTimeData["IqamaOffset"]["Isha"]
		mosque_name_json = IqamaTimeData["IqamaOffset"]["MosqueName"]
		
		fajr_iqama_offset.text = fajr_iqama_offset_json
		dhuhr_iqama_offset.text = dhuhr_iqama_offset_json
		asr_iqama_offset.text = asr_iqama_offset_json
		maghrib_iqama_offset.text = maghrib_iqama_offset_json
		isha_iqama_offset.text = isha_iqama_offset_json
		
		mosque_name_label.text = mosque_name_json
		
		
		

		
	else:
		print('Missing Prayer iqama Json!')


# this will set the prayer time labels to the timings in the json file.
func setprayertimelabel():
	fajr_time.text = military_to_standard_time(fajr_time_json)
	
	sunrise_time.text = military_to_standard_time(sunrise_time_json)
	
	dhuhr_time.text = military_to_standard_time(dhuhr_time_json)
	
	asr_time.text = military_to_standard_time(asr_time_json)
	
	maghrib_time.text = military_to_standard_time(maghrib_time_json)
	
	isha_time.text = military_to_standard_time(isha_time_json)
	
#	this is temp thing, it will set the date label to the date.
	date_label.text = date
	

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
	"IqamaOffset": {
		"MosqueName": mosque_name_text_edit.text,
		"Fajr": fajr_iqama_text_edit.text,
		"Dhuhr": dhuhr_iqama_text_edit.text,
		"Asr": asr_iqama_text_edit.text,
		"Maghrib": maghrib_iqama_text_edit.text,
		"Isha": isha_iqama_text_edit.text
	}
}

	var iqama_string = JSON.stringify(iqama_data, "\t")
	var file = FileAccess.open("res://data/iqama.json", FileAccess.WRITE)
	file.store_string(iqama_string)
	file.close()
	
	



func _on_back_iqama_button_2_pressed():
	color_rect.visible = false
	setiqamacountdownoffset()



func _on_set_iqama_button_pressed():
	color_rect.visible = true


func _on_apply_iqama_button_pressed():
	setiqamatime()
