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


var PrayerTimeData = 'temp'
# Called when the node enters the scene tree for the first time.
func _ready():
	loadprayertime()
	#print(PrayerTimeData)

# this will check if the prayer time json exist and if so it will load it.
func loadprayertime():
#if the file does not exist it will run a func that will save it from github.
	if FileAccess.file_exists("res://data/prayer_timings_military_time.json"):
		var file = FileAccess.open("res://data/prayer_timings_military_time.json", FileAccess.READ)
		PrayerTimeData = JSON.parse_string(file.get_as_text())
	else:
		print('Missing Prayer Time Json, Will proceed to save it!')
		saveprayertime()

#this will request the prayer time json from github.
func saveprayertime():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
