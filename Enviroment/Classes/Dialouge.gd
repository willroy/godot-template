extends Node2D

class_name Dialouge

var textList = null
var textMap = null
var map_current = "START"

func load_file(filename):
	var filePath = "res://Data/DialougeJSON/"+filename+".json"
	var file = File.new()
	file.open(filePath, file.READ)
	var json_as_text = file.get_as_text()
	file.close()
	
	var json_as_dict = parse_json(json_as_text)
	if !json_as_dict:
		return
	
	textList = json_as_dict["text"]
	textMap = json_as_dict["map"]
	
func current_dialouge():
	var current = textMap[map_current]
	var ret = []
	for c in current:
		var diaDict = {}
		diaDict = {"goto": textMap[c]}
		diaDict.merge(textList[c])
		ret.append(diaDict)
	
	return ret

func next_dialouge(id):
	map_current = id

func debugoutputcurrent():
	for t in current_dialouge():
		var s = ""
		for i in range(0, t["goto"].size()):
			s += String(t["goto"][i])
			if i < t["goto"].size()-1:
				s += ", "
		print(t["name"]+": "+t["text"]+" (goes to "+s+")")
