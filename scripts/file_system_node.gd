class_name FileSystemNode
var name : String
var is_directory : bool
var children : Array

func _init(node_name : String, is_dir: bool) -> void:
	name = node_name
	is_directory = is_dir
	children = []

func add_child_node(child):
	if is_directory:
		children.append(child)
		return 
	else:
		return name + "is not a directory"
		
func print_tree(depth: int = 0):
	var indent = "  ".repeat(depth)
	print("%s%s%s" % [indent, name, "/" if is_directory else ""])
	for child in children:
		child.print_tree(depth + 1)

func ls() -> String:
	var res = ""
	for c in children:
		res += c.name + " "
	return res
