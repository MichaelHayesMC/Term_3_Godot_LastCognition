shader_type canvas_item;
uniform bool shader_enabled = true;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	float luminance = (color.r * 0.2126 + color.g * 0.7152 + color.b * 0.0722);
	
	if (!shader_enabled) {
        COLOR = texture(TEXTURE, UV); // normal rendering
    } else {
        // apply your effect
        COLOR = vec4(vec3(luminance), color.a);
    }
		
}