shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
    vec3 color = texture(screen_texture, SCREEN_UV).rgb;

    // Use weighted average for better luminance perception
    float gray = dot(color, vec3(0.299, 0.587, 0.114)); // Standard luminance weights

    gray *= 0.8; // Darken by 20%

    COLOR.rgb = vec3(gray); // Set all RGB to the same luminance
    COLOR.a = 1.0;
}