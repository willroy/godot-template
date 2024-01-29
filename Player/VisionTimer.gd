extends Timer

var old_overlaps = []

func _ready():
	pass

#func _process(delta):
#	pass

func _on_VisionTimer_timeout():
	var visionArea = get_node("../Area")
	var overlaps = visionArea.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.get_parent() != null and overlap.get_parent().is_in_group("Interfaces"):
				var obj = overlap.get_parent()
				if obj.looking_at != null and obj.looking_at == false:
					obj.looking_at = true
					obj.run_look_at()

		for old_overlap in old_overlaps:
			if !overlaps.has(old_overlap) and old_overlap.get_parent() != null and old_overlap.get_parent().is_in_group("Interfaces"):
				var obj = old_overlap.get_parent()
				if obj.looking_at != null and obj.looking_at == true:
					obj.looking_at = false
					obj.run_look_away()
	old_overlaps = overlaps
