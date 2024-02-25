class_name Dialouge

var dialouge = null
var textList = null
var textMap = null
var map_current = "START"

func load_file(filename):
	var filePath = "res://Data/DialougeJSON/"+filename+".json"
	var file = FileAccess.open(filePath, FileAccess.READ)
	var json_as_text = file.get_as_text()
	file.close()
	
	var test_json_conv = JSON.new()
	test_json_conv.parse(json_as_text)
	var json_as_dict = test_json_conv.get_data()
	if !json_as_dict:
		return
	
	textList = json_as_dict["text"]
	textMap = json_as_dict["map"]
	
func current_dialouge():
	var current = textMap[map_current]
	if current == ["START"]:
		current = textMap[current[0]]
	var ret = []
	for c in current:
		var diaDict = {}
		diaDict = {"id": c, "goto": textMap[c]}
		diaDict.merge(textList[c])
		ret.append(diaDict)
	
	return ret

func next_dialouge(id):
	map_current = id
	if textMap[map_current] == ["END"]:
		return false

func debugoutputcurrent():
	for t in current_dialouge():
		var s = ""
		for i in range(0, t["goto"].size()):
			s += String(t["goto"][i])
			if i < t["goto"].size()-1:
				s += ", "
		print(t["name"]+": "+t["text"]+" (goes to "+s+")")
		return t["name"]+": "+t["text"]+" (goes to "+s+")"
