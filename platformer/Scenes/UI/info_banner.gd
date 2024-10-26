extends PanelContainer

class_name InfoBanner
@onready var message_label: Label = %MessageLabel


func message(text:String):
	message_label.text = text

func add_to_message(text: String):
	message_label.text += text
