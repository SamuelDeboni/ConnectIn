extends Node2D

# Resources ---------------
var connections = 1000.0
var influence_points = 0.0
var invites = 0.0

var invite_multi = 1
var invite_bot_multi = 0
var accept_multi = 1
var accept_bot_multi = 0



# Prices --------------------
var invite_script_price = 10
var invite_bot_price = 50
var accept_macro_price = 100
var accept_bot_price = 500

var t = 0.0

var especial_events = 0
var especial_events_costs = [1000,5000,10000,15000,30000,50000]
var especial_events_rewards = [1000,5000,10000,15000,30000,50000]
var especial_events_titles = [" You go to a\n Network Conference"," You atend to a\n Entrepreneurship Presentation","Elon Musk tweets about you","","",""]

func _ready():
	$Control/Store/InviteScript.text = " Invite Macro " + str(invite_script_price) + "IP"
	$Control/Store/InviteBot.text = " Auto Invite Bot " + str(invite_bot_price) + "IP"
	$Control/Store/AcceptMacro.text = " Accept Invite Macro " + str(accept_macro_price) + "IP"
	$Control/Store/AcceptBot.text = " Accept Invite bot " + str(accept_bot_price) + "IP"

func _process(delta):

	t += delta

	# Update Resources
	influence_points += delta*connections*0.1
	connections += invite_bot_multi * delta * 0.1
	invites += connections * delta * 0.005

	if t > 1 and invites > accept_bot_multi:
		invites -= accept_bot_multi
		connections += accept_bot_multi
		t = 0.0

	# Update Text -------------------------------------------------------------
	$Control/ConnectionsT.text = " Connections: " + str(int(connections)) + "\n " + str(int(invite_bot_multi) * 0.1) + "/sec"
	$Control/InfluenceT.text = " IP's " + str(int(influence_points)) + "\n " + str(int(connections)*0.1) + "/sec"
	$Control/Invites.text = " Invites Recived " + str(int(invites))

	if connections > especial_events_costs[especial_events]:
		$Control/Notifications/Dialog.text = especial_events_titles[especial_events] + "\n +" + str(especial_events_rewards[especial_events]) + " IP's"
		$Control/Notifications/Dialog.visible = true
		$Control/Notifications/Dialog.t = 20.0
		influence_points += especial_events_rewards[especial_events]
		especial_events += 1



func _on_SendInvite_button_down():
	if rand_range(0,10) > 9:
		connections += 1 * invite_multi


func _on_InviteScript_button_down():
	if influence_points >= invite_script_price:
		influence_points -= invite_script_price
		invite_multi += 1
		invite_script_price += 2
	$Control/Store/InviteScript.text = str(invite_multi-1) + " Invite Macro " + str(invite_script_price) + "IP"


func _on_InviteBot_button_down():
	if influence_points >= invite_bot_price:
		influence_points -= invite_bot_price
		invite_bot_multi += 1
		invite_bot_price += 5
	$Control/Store/InviteBot.text = str(invite_bot_multi) + " Auto Invite Bot " + str(invite_bot_price) + "IP"


func _on_AcceptInvite_button_down():
	if invites >= 1 * accept_multi:
		invites -= 1 * accept_multi
		connections += 1 * accept_multi

func _on_AcceptMacro_button_down():
	if influence_points >= accept_macro_price:
		accept_multi += 1
		influence_points -= accept_macro_price
		accept_macro_price += 10
	$Control/Store/AcceptMacro.text = str(accept_multi-1) + " Accept Invite Macro " + str(accept_macro_price) + "IP"

func _on_AcceptBot_button_down():
	if influence_points >= accept_bot_price:
		accept_bot_multi += 1
		influence_points -= accept_bot_price
		accept_bot_price += 50
	$Control/Store/AcceptBot.text = str(accept_bot_multi) + " Accept Invite Bot " + str(accept_bot_price) + "IP"
