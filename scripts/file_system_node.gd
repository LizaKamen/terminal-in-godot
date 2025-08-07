class_name FileSystemNode
var name : String
var is_directory : bool
var children : Array
var size : int
var content : String
var parent : FileSystemNode

func _init(node_name : String, is_dir: bool, file_content := "") -> void:
	name = node_name
	is_directory = is_dir
	children = []
	size = file_content.length() if not is_dir else 0
	content = file_content if not is_dir else ""

func add_child_node(child : FileSystemNode):
	if is_directory:
		children.append(child)
		child.parent = self
		print("Added " + child.name + " to " + self.name)
		return 
	else:
		return name + "is not a directory"
		
func add_children_nodes(children_to_add : Array[FileSystemNode]):
	for child : FileSystemNode in children_to_add:
		add_child_node(child)

func print_tree(depth: int = 0):
	var indent = "  ".repeat(depth)
	print("%s%s%s" % [indent, name, "/" if is_directory else ""])
	for child in children:
		child.print_tree(depth + 1)

func print_children() -> String:
	var res = ""
	for c in children:
		res += c.name + " "
	return res
	
func get_size() -> int:
	if(!is_directory):
		return size
	else:
		var s = 0
		for c : FileSystemNode in children:
			s += c.get_size()
		return s

func get_full_path() -> String:
	var path = ""
	if(parent):
		path += parent.get_full_path()
	if(name == "/"):
		path += name
	else: 
		path += name + "/"
	return path
