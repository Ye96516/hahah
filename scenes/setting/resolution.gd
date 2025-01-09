extends OptionButton

var resolution_dir:Dictionary={
	"3840x2160": Vector2i(3840 ,2160),
	"2560x1440": Vector2i( 2560,1440),
	"1800x1000":Vector2i( 1800,1000),
	"1920x1080": Vector2i(1920,1080) ,
	"1366x768": Vector2i (1366,768),
	"1280x720": Vector2i(1280, 720) ,
	"1440x900": Vector2i(1440,900) ,
	"1600x900":Vector2i (1600,900),
	"1024x600": Vector2i(1024, 600) ,
	"800x600": Vector2i(800, 600) ,
}

func _ready() -> void:
	_add_resolution()
	_render_current_resolution()

func _add_resolution():
	for i in resolution_dir:
		self.add_item(i)

func _render_current_resolution():
	var current_resolution:String=str(get_viewport().size.x,"x",get_viewport().size.y)
	var resolution_key=resolution_dir.keys().find(current_resolution)
	if resolution_key<0:
		add_item(current_resolution)
		self.selected=resolution_dir.size()
	self.selected=resolution_key

func _on_resolution_item_selected(index: int) -> void:
	var key=self.get_item_text(index)
	#更改窗口尺寸
	get_window().set_size(resolution_dir[key])
