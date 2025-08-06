extends Control

@onready var rich_text_label = $RichTextLabel
@onready var line_edit = $LineEdit
var timer = 0
@export var blink_period = 0.5
var careet_visible
var saved_text : String
var input_text : String
var fastfetch_data = "I use Arch btw"
var file_system : FileSystemNode
var current_dir : FileSystemNode
@export var pc_name : String = "lizakamen"
var welcom_msg : String

func _ready() -> void:
	line_edit.grab_focus()
	file_system = FileSystemNode.new("home", true)
	var dir1 = FileSystemNode.new("dir1", true)
	var dir2 = FileSystemNode.new("dir2", true)
	var file1 = FileSystemNode.new("file1", false)
	var file2 = FileSystemNode.new("file2", false)
	file_system.add_child_node(dir1)
	file_system.add_child_node(dir2)
	dir1.add_child_node(file1)
	file_system.add_child_node(file2)
	file_system.print_tree()
	current_dir = file_system
	welcom_msg = pc_name + ":" + current_dir.name + "#"
	saved_text += welcom_msg
	
func _process(delta: float) -> void:
	if(timer > blink_period):
		careet_visible = not careet_visible
		timer = 0
		print(careet_visible)
	timer += delta
	if(careet_visible):	
		rich_text_label.text = saved_text + input_text + "⎸"
	else:
		rich_text_label.text = saved_text + input_text

func _on_line_edit_text_changed(new_text: String) -> void:
	input_text = new_text

func _on_line_edit_text_submitted(new_text: String) -> void:
	var command_name = new_text.substr(0, new_text.find(" "))
	var args_string = new_text.substr(new_text.find(" ") + 1)
	saved_text += new_text + "\n"
	line_edit.text = ""
	input_text = ""
	if (command_name == "echo"):
		saved_text += args_string
	elif (command_name == "fastfetch"):
		saved_text += fastfetch_data
	elif (command_name == "ls"):
		saved_text += current_dir.ls()
	elif (command_name == "pwd"):
		saved_text += "/" + current_dir.name
	elif (command_name == "cd"):
		pass
	else:
		saved_text += "Command not found"
	saved_text += "\n" + welcom_msg
