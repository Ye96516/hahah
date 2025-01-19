shader_type canvas_item;

// 可调节的参数
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_width : hint_range(0, 10) = 2.0;

void fragment() {
    // 获取原始纹理的颜色
    vec4 original_color = texture(TEXTURE, UV);
    
    // 计算纹理大小
    vec2 tex_size = 1.0 / vec2(textureSize(TEXTURE, 0));
    
    // 初始化描边的alpha值
    float outline_alpha = 0.0;
    
    // 采样周围的像素检查是否需要绘制描边
    for(float x = -outline_width; x <= outline_width; x++) {
        for(float y = -outline_width; y <= outline_width; y++) {
            if(x == 0.0 && y == 0.0) continue;
            
            vec2 offset = vec2(x, y) * tex_size;
            vec4 neighbor_color = texture(TEXTURE, UV + offset);
            
            // 如果找到不透明像素，增加描边alpha值
            if(neighbor_color.a > 0.0) {
                float dist = length(vec2(x, y)) / outline_width;
                outline_alpha = max(outline_alpha, 1.0 - dist);
            }
        }
    }
    
    // 如果原始像素透明且周围有不透明像素，则绘制描边
    if(original_color.a < 0.1 && outline_alpha > 0.0) {
        COLOR = vec4(outline_color.rgb, outline_color.a * outline_alpha);
    } else {
        COLOR = original_color;
    }
}