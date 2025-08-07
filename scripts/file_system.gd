class_name FileSystem

var file_system_root : FileSystemNode

func _init() -> void:
	file_system_root = FileSystemNode.new("/", true)
	var bin_dir = create_bin()
	var etc_dir = create_etc()
	var var_dir = create_var()
	var tmp_dir = create_tmp()
	
	var proc_dir = create_proc()
	var srv_dir = FileSystemNode.new("srv", true)
	var home_dir = FileSystemNode.new("home", true)
	var mnt_dir = FileSystemNode.new("mnt", true)
	
	var dev_dir = FileSystemNode.new("dev", true)
	
	file_system_root.add_children_nodes([
		bin_dir,
		etc_dir,
		var_dir,
		tmp_dir,
		proc_dir,
		srv_dir,
		home_dir,
		mnt_dir,
		dev_dir])

func create_bin() -> FileSystemNode:
	var bin_dir = FileSystemNode.new("bin", true)
	
	for c in Commands.commands:
		bin_dir.add_child_node(FileSystemNode.new(c, false, Commands.commands[c]))
		
	return bin_dir
	
func create_etc() -> FileSystemNode:
	var etc_dir = FileSystemNode.new("etc", true)
	# todo add config files here
	return etc_dir
	
func create_tmp() -> FileSystemNode:
	var tmp_dir = FileSystemNode.new("tmp", true)
	# tofo generate random files here (to check size later and clear if nedeed)
	return tmp_dir
	
func create_var() -> FileSystemNode:
	var var_dir = FileSystemNode.new("var", true)
	var log_dir = FileSystemNode.new("log", true)
	var lib_dir = FileSystemNode.new("lib", true)
	var cache_dir = FileSystemNode.new("cache", true)
	var run_dir = FileSystemNode.new("run", true)
	var_dir.add_child_node(log_dir)
	var_dir.add_child_node(lib_dir)
	var_dir.add_child_node(cache_dir)
	var_dir.add_child_node(run_dir)
	return var_dir

func create_proc() -> FileSystemNode:
	var proc_dir = FileSystemNode.new("proc", true)
	
	return proc_dir
