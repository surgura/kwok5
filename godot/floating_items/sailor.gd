extends "res://floating_items/floating_item.gd"

export(NodePath) var inventory_path: NodePath
export(NodePath) var tiersystem_path: NodePath
export(NodePath) var textbox_path: NodePath

const tex_sailor = preload("res://images/character01.png")

var convs = [
	{
		"enter": [
			{
				"text": "Oh no you sank",
				"img": tex_sailor
			},
			{
				"text": "This was bad",
				"img": tex_sailor
			},
			{
				"text": "Let's repair",
				"img": tex_sailor
			}
		],
		"firsttimetask": {
			"text": "you will need to get: ",
			"img": tex_sailor
		},
		"noloot": {
			"text": "you need more shit. We need: ",
			"img": tex_sailor
		},
		"someloot": {
			"text": "good job keep it up. We need: ",
			"img": tex_sailor
		},
		"tierup": {
			"text": "nice bro next tier",
			"img": tex_sailor
		}
	},
	{
		"enter": [
			{
				"text": "this is tier 2",
				"img": tex_sailor
			}
		],
		"firsttimetask": {
			"text": "you will need to get tier 2: ",
			"img": tex_sailor
		},
		"noloot": {
			"text": "you need more shit tier 2.  We need: ",
			"img": tex_sailor
		},
		"someloot": {
			"text": "good job keep it up tier 2.  We need: ",
			"img": tex_sailor
		},
		"tierup": {
			"text": "nice bro next tier tier 2",
			"img": tex_sailor
		}
	}
]

var state
var conv_index

func _ready():
	set_state_start_tier()
	#on_hit_raft()

func set_state_start_tier():
	state = "start_tier"
	conv_index = 0
	
func next_message():
	var tiersystem = get_node(tiersystem_path)
	var tier_index = tiersystem.get_current_tier()-1
	
	var textbox = get_node(textbox_path)
	
	if conv_index >= len(convs[tier_index]["enter"]):
		var req = requirement_list()
		textbox.disconnect("on_close", self, "next_message")
		var base_text = convs[tier_index]["firsttimetask"]["text"]
		state = "deliver"
		textbox.show_stuff(base_text + "\n\n" + req, convs[tier_index]["firsttimetask"]["img"])
	else:
		textbox.connect("on_close", self, "next_message")
		textbox.show_stuff(convs[tier_index]["enter"][conv_index]["text"], convs[tier_index]["enter"][conv_index]["img"])
		conv_index += 1

func requirement_list():
	var tiersystem = get_node(tiersystem_path)
	var reqs = tiersystem.find_required_items(tiersystem.get_current_tier())
	var res = ""
	for req in reqs.keys():
		res += "- " + str(reqs[req]) + " " + req.replace("_", " ") + "\n"
		
	return res

func deliver():
	var inventory = get_node(inventory_path)
	var tiersystem = get_node(tiersystem_path)
	var tier_index = tiersystem.get_current_tier()-1
	var textbox = get_node(textbox_path)
	var result = tiersystem.deliver(inventory)
	if result == 3: # tierup
		state = "start_tier"
		textbox.connect("on_close", self, "next_message")
		textbox.show_stuff(convs[tier_index]["tierup"]["text"], convs[tier_index]["tierup"]["img"])
	elif result == 1: # partially
		var req = requirement_list()
		var base_text = convs[tier_index]["someloot"]["text"]
		textbox.show_stuff(base_text + "\n\n" + req, convs[tier_index]["someloot"]["img"])
	elif result == 2: # nothing
		var req = requirement_list()
		var base_text = convs[tier_index]["noloot"]["text"]
		textbox.show_stuff(base_text + "\n\n" + req, convs[tier_index]["someloot"]["img"])
	else:
		print("ERRORORORRRRR IN TIER SYSTEMMMMM")

func on_hit_raft() -> void:
	if state == "start_tier":
		next_message()
	else:
		deliver()
