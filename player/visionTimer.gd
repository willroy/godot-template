extends Timer

var old_overlaps = []

func _on_timeout():
	var visionArea = get_node("../visionArea")
	var overlaps = visionArea.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.get_parent() != null and overlap.get_parent().is_in_group("interface"):
				var obj = overlap.get_parent()
				if obj.looking_at != null and obj.looking_at == false:
					obj.looking_at = true
					obj.run_look_at()

		for old_overlap in old_overlaps:
			if !overlaps.has(old_overlap) and old_overlap.get_parent() != null and old_overlap.get_parent().is_in_group("interface"):
				var obj = old_overlap.get_parent()
				if obj.looking_at != null and obj.looking_at == true:
					obj.looking_at = false
					obj.run_look_away()
	old_overlaps = overlaps
