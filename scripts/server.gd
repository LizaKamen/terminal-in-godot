class_name Server
var vpn_connected := false
var is_online := true
var ip : String
var neighbors := []

func ping(target_ip : String) -> Dictionary:
	if not is_online:
		return {"success" : false, "error" : "host unreachable"}
	
	if target_ip == ip:
		return {"success": true, "time": 0.1}
	
	for neighbor : Server in neighbors:
		if neighbor.ip == target_ip:
			if neighbor.vpn_connected and neighbor.is_online:
				return {"success" : true, "time" : randf_range(5, 50)}
	
	return {"success" : false, "error" : "request timed out"}
