extends Node2D

# Resources ---------------
var connections = 0
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
var especial_events_costs = [1000,10000,100000,1000000,10000000,100000000]
var especial_events_rewards = [1000,10000,100000,1000000,10000000,100000000]
var especial_events_titles = [" You go to a\n Network Conference"," You atend to a\n Entrepreneurship Presentation","Elon Musk tweets about you"," You appeared on PewNews"," You got a post into LAWAY"," You host meme review"]

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
		if especial_events < 5:
			especial_events += 1



func _on_SendInvite_button_down():
	if rand_range(0,10) > 5:
		connections += 1 * invite_multi
	$AudioStreamPlayer.play()

func _on_InviteScript_button_down():
	if influence_points >= invite_script_price:
		influence_points -= invite_script_price
		invite_multi *= 1.1
		invite_script_price *= 1.2
	$Control/Store/InviteScript.text =  " Invite Macro " + str(invite_script_price) + "IP"
	$Control/Status/IM_speed.text = " Invite Macro:\n " + str(invite_multi) + "/clik"
	$AudioStreamPlayer.play()

func _on_InviteBot_button_down():
	if influence_points >= invite_bot_price:
		influence_points -= invite_bot_price
		if invite_bot_multi == 0:
			invite_bot_multi += 1
		else:
			invite_bot_multi *= 1.2
		invite_bot_price *= 1.1
	$Control/Store/InviteBot.text =  " Auto Invite Bot " + str(invite_bot_price) + "IP"
	$Control/Status/IB_speed.text = " Invite Bot Speed:\n " + str(invite_bot_multi*0.1) + "/s"
	$AudioStreamPlayer.play()

func _on_AcceptInvite_button_down():
	if invites >= 1 * accept_multi:
		invites -= 1 * accept_multi
		connections += 1 * accept_multi
	else:
		connections += invites
		invites = 0
	$AudioStreamPlayer.play()

func _on_AcceptMacro_button_down():
	if influence_points >= accept_macro_price:
		accept_multi *= 1.2
		influence_points -= accept_macro_price
		accept_macro_price *= 1.1
	$Control/Store/AcceptMacro.text = " Invite Accept Macro " + str(accept_macro_price) + "IP"
	$Control/Status/AM_speed.text = " Invite Accept Macro:\n " + str(accept_multi) + "/click" 
	$AudioStreamPlayer.play()
	
func _on_AcceptBot_button_down():
	if influence_points >= accept_bot_price:
		if accept_bot_multi == 0:
			accept_bot_multi += 1
		else:
			accept_bot_multi *= 1.2
		influence_points -= accept_bot_price
		accept_bot_price *= 1.1
	$Control/Store/AcceptBot.text = " Accept Invite Bot " + str(accept_bot_price) + "IP"
	$Control/Status/AB_speed.text = " Invite Accept Bot speed:\n " + str(accept_bot_multi)+"/s"
	$AudioStreamPlayer.play()