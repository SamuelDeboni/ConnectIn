extends Node2D

var connections = 0
var influence_points = 0.0
var influence_mult = 0.1

func _ready():
	pass 


func _process(delta):
	influence_points += delta*connections*influence_mult
	
	$Control/ConnectionsT.text = "Connections " + str(connections)
	$Control/InfluenceT.text = "Influence points " + str(influence_points)


func _on_SendInvite_button_down():
	if rand_range(0,10) > 9:
		connections += 1
