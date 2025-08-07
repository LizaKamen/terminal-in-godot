class_name FileSystemCommandsHandler

static func cd_handler(args : String, context):
	if (args == ".." and not context.current_dir.parent):
		return
	elif (args == ".."):
		context.current_dir = context.current_dir.parent
		return
	for c : FileSystemNode in context.current_dir.children:
		if(not c.is_directory):
			return "cd: " + c.name + ": Not a directory" 
		if(c.name == args):
			context.current_dir = c
			return

static func mkdir_handler(folder_name : String, context):
	var new_node = FileSystemNode.new(folder_name, true)
	context.current_dir.add_child_node(new_node)
	
static func touch_handler(file_name: String, context):
	var new_node = FileSystemNode.new(file_name, false)
	context.current_dir.add_child_node(new_node)

static func cat_handler(file : FileSystemNode) -> String:
	return file.content
	
