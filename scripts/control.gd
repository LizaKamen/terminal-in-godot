extends Control

@onready var rich_text_label = $RichTextLabel
@onready var line_edit = $LineEdit
var network_manager : NetworkManager
var current_server : Server
var timer = 0
@export var blink_period = 0.5
var careet_visible
var saved_text : String
var input_text : String
var fastfetch_data = "I use Arch btw"
var root : FileSystemNode
var current_dir : FileSystemNode
@export var pc_name : String = "MyCoolPC"
@export var user_name : String = "lizakamen"
var welcom_msg : String
var path : String

func _ready() -> void:
	# networking
	var server1 = Server.new()
	server1.ip = "192.168.1.1"
	
	var server2 = Server.new()
	server2.ip = "192.168.1.2"
	
	server1.neighbors.append(server2)
	server2.neighbors.append(server1)
	
	network_manager = NetworkManager.new()
	
	network_manager.servers[server1.ip] = server1
	network_manager.servers[server2.ip] = server2
	
	network_manager.connect_vpn(server1.ip)
	network_manager.connect_vpn(server2.ip)
	
	current_server = server1
	
	# networking
	
	line_edit.grab_focus()
	root = FileSystem.new().file_system_root
	current_dir = root
	path = "~"
	welcom_msg = "[color=green]" + user_name + "@" + pc_name + "[/color]" + ":" + "[color=blue]" + path + "[/color]" + "$"
	saved_text += welcom_msg
	
func _process(delta: float) -> void:
	if(timer > blink_period):
		careet_visible = not careet_visible
		timer = 0
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
	
	match command_name:
		"echo":
			saved_text += args_string + "\n"
		"fastfetch":
			saved_text += fastfetch_data + "\n"
		"ls":
			var ls = current_dir.print_children()
			if(ls == ""):
				pass
			else:
				saved_text += ls + "\n"
		"pwd":
			saved_text += "/" + current_dir.name + "\n"
		"cd":
			var output = FileSystemCommandsHandler.cd_handler(args_string, self)
			if(output):
				saved_text += output + "\n"
			path = current_dir.get_full_path()
			path = path.substr(0, path.length() - 1)
			welcom_msg = "[color=green]" + user_name + "@" + pc_name + "[/color]" + ":" + "[color=blue]" + path + "[/color]" + "$"
		"mkdir":
			FileSystemCommandsHandler.mkdir_handler(args_string, self)
		"touch":
			FileSystemCommandsHandler.touch_handler(args_string, self)
		"man":
			saved_text += MiscellaneousCommandsHandler.man_handler(args_string) + "\n"
		"cat":
			for c : FileSystemNode in current_dir.children:
				if(c.name == args_string and not c.is_directory):
					saved_text += FileSystemCommandsHandler.cat_handler(c) + "\n"
		"ping":
			var res = current_server.ping(args_string)
			if res.success:
				saved_text += "64 bytes from %s: icmp_seq=1 ttl=64 time=%.1f ms\n" % [args_string, res.time]
			else:
				saved_text += "ping: %s\n" % res.error
		_:
			saved_text += "Command not found" + "\n"
			
	saved_text += welcom_msg
