shader_type canvas_item;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float luminance = (color.r * 0.2126 + color.g * 0.7152 + color.b * 0.0722);
	
	COLOR = vec4(vec3(luminance), color.a);
}