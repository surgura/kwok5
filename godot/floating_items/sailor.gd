extends "res://floating_items/floating_item.gd"

export(NodePath) var inventory_path: NodePath
export(NodePath) var tiersystem_path: NodePath
export(NodePath) var textbox_path: NodePath
export(NodePath) var ship_path: NodePath

const tex_sailor = preload("res://images/sailor_swim.png")
const tex_you = preload("res://images/sailor_head.png")

var start_timer

var convs = [
	{
		"enter": [
			{
				"text": "Sailor: …What happened? All I can remember are the tentacles… Last time I saw those was when I was watching that hent… never mind.",
				"img": tex_sailor
			},
			{
				"text": "Is that our ship?",
				"img": tex_you
			},
			{
				"text": "Damn, we need to fix that so we can get out of here. How about you hook me up with the stuff I need? I can use it to rebuild the ship.",
				"img": tex_sailor
			}
		],
		"firsttimetask": {
			"text": "Alright, here's what we need to get started: ",
			"img": tex_sailor
		},
		"noloot": {
			"text": "Come on bro, get me the items. I'm freezing down here. By the way, why won't you let me onto your raft anyway?\n\nI need:",
			"img": tex_sailor
		},
		"someloot": {
			"text": "Alright, getting there. Here's what's left:",
			"img": tex_sailor
		},
		"tierup": {
			"text": "Great! That'll do nicely. Let's patch this ship up…",
			"img": tex_sailor
		}
	},
	{
		"enter": [
			{
				"text": "Alright, that's a bit better, but I don't think that's quite gonna float our boat yet.",
				"img": tex_sailor
			}
		],
		"firsttimetask": {
			"text": "We need some sails. Can you get me:",
			"img": tex_sailor
		},
		"noloot": {
			"text": "You didn't bring me anything useful. Get your shit together and bring me:",
			"img": tex_sailor
		},
		"someloot": {
			"text": "Good, making progress here. We need:",
			"img": tex_sailor
		},
		"tierup": {
			"text": "Alright let's make this baby sail!'",
			"img": tex_sailor
		}
	},
	{
		"enter": [
			{
				"text": "Looks like she's not quite keeping her head above the water, but a little birdie just told me there's a treasure chest and diamonds floating around here…",
				"img": tex_sailor
			},
			{
				"text": "This is not the time to get greedy man…",
				"img": tex_you
			},
			{
				"text": "C'mon man. This is our one shot. Do not miss your chance to blow. This opportunity comes once in a lifetime yarr.",
				"img": tex_sailor
			}
		],
		"firsttimetask": {
			"text": "Get me dat bootey:",
			"img": tex_sailor
		},
		"noloot": {
			"text": "Stop bumping into me if you don't have the bootey:",
			"img": tex_sailor
		},
		"someloot": {
			"text": "Cool, here's what's left:",
			"img": tex_sailor
		},
		"tierup": {
			"text": "Nice bro! I'm gonna be rich! I mean we… We're gonna be rich.",
			"img": tex_sailor
		}
	},
	{
		"enter": [
			{
				"text": "I think I have enough to fix the rest, but I'm kinda dying here…",
				"img": tex_sailor
			}
		],
		"firsttimetask": {
			"text": "Can you get me some something to eat? How about:",
			"img": tex_sailor
		},
		"noloot": {
			"text": "I'm hungry, get outta here and get:",
			"img": tex_sailor
		},
		"someloot": {
			"text": "Still hungry for dat:",
			"img": tex_sailor
		},
		"tierup": {
			"text": "Hmmm! This global game jam is delicious. Time to set sail matey!",
			"img": tex_sailor
		}
	}
]

var state
var conv_index

func _ready():
	set_state_start_tier()
	start_timer = Timer.new()
	start_timer.connect("timeout", self, "startstuff")
	add_child(start_timer)
	start_timer.set_wait_time(0.5)
	start_timer.start()
	
func startstuff():
	start_timer.stop()
	on_hit_raft()

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
	inventory.output()
	
	var result = tiersystem.deliver(inventory)
	if result == 3: # tierup
		get_node(ship_path).tier = tier_index+1
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
