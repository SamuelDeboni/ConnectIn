extends Node2D

# Resources ---------------
var connections = 0.0
var influence_points = 0.0


var invite_multi = 1
var invite_bot_multi = 0
var accept_mult = 1

var invites = 0.0

# Prices --------------------
var invite_script_price = 10
var invite_bot_price = 50

func _ready():
	$Control/Store/InviteScript.text = " Invite Script " + str(invite_script_price) + "IP" 
	$Control/Store/InviteBot.text = " Auto Invite Bot " + str(invite_bot_price) + "IP"
	
	


func _process(delta):
	influence_points += delta*connections*0.1
	connections += invite_bot_multi * delta * 0.1
	invites += connections * delta * 0.01
	
	$Control/ConnectionsT.text = "Connections " + str(int(connections)) + " " + str(int(invite_bot_multi) * 0.1) + "/sec"
	$Control/InfluenceT.text = "Influence points " + str(int(influence_points)) + " " + str(int(connections)*0.1) + "/sec"
	$Control/Invites.text = "Invites Recived " + str(int(invites))

func _on_SendInvite_button_down():
	if rand_range(0,10) > 9:
		connections += 1 * invite_multi


func _on_InviteScript_button_down():
	if influence_points >= invite_script_price:
		influence_points -= invite_script_price
		invite_multi += 1
		invite_script_price += 2
	$Control/Store/InviteScript.text = str(invite_multi-1) + " Invite Script " + str(invite_script_price) + "IP" 


func _on_InviteBot_button_down():
	if influence_points >= invite_bot_price:
		influence_points -= invite_bot_price
		invite_bot_multi += 1
		invite_bot_price += 5
	$Control/Store/InviteBot.text = str(invite_bot_multi) + " Auto Invite Bot " + str(invite_bot_price) + "IP"


func _on_AcceptInvite_button_down():
	if invites >= 1 * accept_mult:
		invites -= 1 * accept_mult
		connections += 1 * accept_mult
