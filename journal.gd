class_name Journal
extends Control

enum Mode { JOURNAL_ENTRY, INTERSEQUENCE }
enum SfxType { PAGE_TURN, WRITING }

@export var journal_entry_override: JournalEntryData
@export var attitude_min_color: Color = Color("E21200")
@export var attitude_max_color: Color = Color("00D0E2")
@export var camaraderie_min_color: Color = Color("971DFF")
@export var camaraderie_max_color: Color = Color("5FE200")
@export_category("Audio")
@export var page_turn_sfx: Array[SoundEffectData] = []
@export var writing_sfx: Array[SoundEffectData] = []

@onready var choice_container: HFlowContainer = %ChoiceContainer
@onready var entry_label: JournalLabel = %EntryLabel
@onready var journal_entry_container: VBoxContainer = %JournalEntryContainer
@onready var intersequence_container: Control = %IntersequenceContainer
@onready var sequence_button_container: VBoxContainer = %SequenceButtonContainer
@onready var effects_player: AudioStreamPlayer = $EffectsPlayer
@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var attitude_bar: ProgressBar = %AttitudeBar
@onready var camaraderie_bar: ProgressBar = %CamaraderieBar

const choice_button_scene: PackedScene = preload("res://UI/choice_button.tscn")
const continue_button_data: ChoiceData = preload("res://Data/continue.tres")

var choice_made: bool = false
var choice_index: int = 0
var current_entry: JournalEntryData

func _ready() -> void:
	var attitude_background_stylebox: StyleBox = attitude_bar.get_theme_stylebox("background")
	attitude_background_stylebox.set("bg_color", attitude_min_color)
	attitude_bar.add_theme_stylebox_override("background", attitude_background_stylebox)
	var attitude_fill_stylebox: StyleBox = attitude_bar.get_theme_stylebox("fill")
	attitude_fill_stylebox.set("bg_color", attitude_max_color)
	attitude_bar.add_theme_stylebox_override("fill", attitude_fill_stylebox)
	var camaraderie_background_stylebox: StyleBox = camaraderie_bar.get_theme_stylebox("background")
	camaraderie_background_stylebox.set("bg_color", camaraderie_min_color)
	camaraderie_bar.add_theme_stylebox_override("background", camaraderie_background_stylebox)
	var camaraderie_fill_stylebox: StyleBox = camaraderie_bar.get_theme_stylebox("fill")
	camaraderie_fill_stylebox.set("bg_color", camaraderie_max_color)
	camaraderie_bar.add_theme_stylebox_override("fill", camaraderie_fill_stylebox)
	#attitude_bar.theme_override_styles/"background"/"bg_color" = attitude_max_color
	for child in sequence_button_container.get_children():
		var sequence_button: SequenceButton = child
		sequence_button.pressed.connect(_on_sequence_button_pressed.bind(sequence_button.sequence_tag))
	_clear_choices()
	if journal_entry_override:
		current_entry = journal_entry_override
	else:
		current_entry = JournalManager.get_sequence_start("prologue")
	_start_current_entry()

func _on_entry_label_donezo() -> void:
	if choice_made:
		var has_next_entry: bool = true if current_entry.next_entry else false
		if has_next_entry:
			current_entry = current_entry.next_entry
			entry_label.append_text(_get_current_entry_text())
			entry_label.start_text_advance()
		else:
			# TODO: Move to Intersequence Mode (Perhaps not needed?)
			# We're already doing that in the continue button handler.
			pass
		choice_made = false
	else:
		_show_choices()

func _on_choice_button_pressed(choice_data: ChoiceData) -> void:
	# TODO (REACH): Add choice selection animation.
	_clear_choices()
	var choice_history: Array = JournalManager.sequences[current_entry.sequence_tag].choice_history
	choice_history.append(choice_data)
	entry_label.append_choice_text(choice_data.text + "\n")
	JournalManager.apply_choice_effects(choice_data)
	choice_made = true
	_play_sfx(SfxType.WRITING)

func _on_continue_button_pressed() -> void:
	_clear_choices()
	_play_sfx(SfxType.PAGE_TURN)
	if current_entry.next_entry:
		current_entry = current_entry.next_entry
		_start_current_entry()
	else:
		print("SEQUENCE COMPLETE. MOVING TO INTERSEQUENCE MODE.")
		JournalManager.sequences[current_entry.sequence_tag].complete = true
		_change_mode(Mode.INTERSEQUENCE)

func _on_reset_button_pressed() -> void:
	JournalManager.reset_progress()
	_change_mode(Mode.INTERSEQUENCE)

func _on_sequence_button_pressed(sequence_tag: String) -> void:
	current_entry = JournalManager.get_sequence_start(sequence_tag)
	choice_index = 0
	_start_current_entry()
	_play_sfx(SfxType.PAGE_TURN)

func _change_mode(mode: Mode) -> void:
	match mode:
		Mode.JOURNAL_ENTRY:
			journal_entry_container.show()
			intersequence_container.hide()
		Mode.INTERSEQUENCE:
			journal_entry_container.hide()
			intersequence_container.show()
			var available_sequence_keys: Array[String] = JournalManager.get_available_sequences()
			for child in sequence_button_container.get_children():
				var sequence_button: SequenceButton = child
				if available_sequence_keys.has(sequence_button.sequence_tag):
					sequence_button.show()
				else:
					sequence_button.hide()
			_update_stats()

func _clear_entry_label() -> void:
	entry_label.clear()

func _clear_choices() -> void:
	for child in choice_container.get_children():
		child.queue_free()

func _get_current_entry_text() -> String:
	var text: String = ""
	for text_with_requirements in current_entry.texts:
		if text_with_requirements.requirements.is_empty():
			text += text_with_requirements.text
			continue
		if text_with_requirements.are_requirements_fulfilled():
			var key: String = text_with_requirements.world_key
			var value: int = JournalManager.world[key]
			var color_min: Color
			var color_max: Color
			if key == "player.attitude":
				color_min = attitude_min_color
				color_max = attitude_max_color
			else:
				color_min = camaraderie_min_color
				color_max = camaraderie_max_color
			var lerp_weight: float = clamp((float(value) + 4.0) / 8.0, 0.0, 8.0)
			var color_string: String = color_min.lerp(color_max, lerp_weight).to_html(false)
			text += "[color=#%s][outline_size=4]%s[/outline_size][/color]" % [color_string, text_with_requirements.text]
			break
	return text

func _play_sfx(sfx_type: SfxType) -> void:
	var audio_array: Array[SoundEffectData]
	match sfx_type:
		SfxType.PAGE_TURN:
			audio_array = page_turn_sfx
		SfxType.WRITING:
			audio_array = writing_sfx
	var audio_data: SoundEffectData = audio_array[randi_range(0, audio_array.size() - 1)]
	effects_player.set_stream(audio_data.audio)
	effects_player.set_volume_db(audio_data.volume_override)
	effects_player.play()

func _show_choices() -> void:
	# By default, we add a continue button so we can load the next entry in the sequence.
	# TODO: Add a flag to determine whether to show a continue button or to automatically
	# append the next entry to the journal label.
	if current_entry.choices.is_empty():
		var continue_button: ChoiceButton = choice_button_scene.instantiate()
		continue_button.initialize(continue_button_data)
		continue_button.pressed.connect(_on_continue_button_pressed)
		choice_container.add_child(continue_button)
		return
		
	var choices: Array[ChoiceData] = current_entry.choices
	if JournalManager.sequences[current_entry.sequence_tag].complete:
		var choice_history: Array = JournalManager.sequences[current_entry.sequence_tag].choice_history
		for choice_data in choices:
			if choice_data == choice_history[choice_index]:
				choice_index += 1
				entry_label.append_choice_text(choice_data.text + "\n")
				choice_made = true
				return
		
	for choice_data in choices:
		var data: ChoiceData = choice_data
		var new_button: ChoiceButton = choice_button_scene.instantiate()
		new_button.initialize(data)
		new_button.pressed.connect(_on_choice_button_pressed.bind(data))
		choice_container.add_child(new_button)

func _start_current_entry() -> void:
	# TODO: Replay the player's choice history.
	_change_mode(Mode.JOURNAL_ENTRY)
	var text: String = _get_current_entry_text()
	entry_label.initialize(text)
	entry_label.start_text_advance()
	
func _update_stats() -> void:
	attitude_bar.set_value(clampi(JournalManager.world["player.attitude"], -3, 3))
	camaraderie_bar.set_value(clampi(JournalManager.world["player.camaraderie"], -3, 3))
	
