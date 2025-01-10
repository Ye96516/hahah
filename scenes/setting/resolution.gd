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
var sl:SLSystem=SLSystem.new()

func _ready() -> void:
	_add_resolution()
	_render_current_resolution()

func _add_resolution():
	for i in resolution_dir:
		self.add_item(i)

func _render_current_resolution():
	if sl.has_key("screen_size"):
		var ss:Vector2i=DisplayServer.screen_get_size()
		var screen_size:Vector2=sl.load_data("screen_size")
		get_window().set_size(screen_size)
		var window_pos=Vector2(ss.x/2-screen_size.x/2,ss.y/2-screen_size.y/2)
		DisplayServer.window_set_position(window_pos,0)
	
	var current_resolution:String=str(get_viewport().size.x,"x",get_viewport().size.y)
	var resolution_key=resolution_dir.keys().find(current_resolution)
	if resolution_key<0:
		add_item(current_resolution)
		self.selected=resolution_dir.size()
		return
	self.selected=resolution_key

func _on_resolution_item_selected(index: int) -> void:
	var key=self.get_item_text(index)
	#更改窗口尺寸
	get_window().set_size(resolution_dir[key])
	var ss:Vector2i=DisplayServer.screen_get_size()
	var window_pos=Vector2(ss.x/2-resolution_dir[key].x/2,ss.y/2-resolution_dir[key].y/2)
	DisplayServer.window_set_position(window_pos,0)
	sl.save_data("screen_size",resolution_dir[key])
