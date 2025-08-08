class_name NetworkManager

var servers : Dictionary[String, Server] = {}

func connect_vpn(server_ip: String) -> bool:
	if servers.has(server_ip):
		servers[server_ip].vpn_connected = true
		return true
	return false
	
func disconnect_vpn(server_ip : String) -> void:
	if servers.has(server_ip):
		servers[server_ip].vpn_connected = false
		
func get_server(ip: String) -> Server:
	return servers.get(ip)
