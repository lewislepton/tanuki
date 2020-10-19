#version 450

uniform sampler2D tex;
in vec2 texCoord;
uniform vec2 u_resolution;
uniform float u_time;
out vec4 fragColor;


uniform float angle;
uniform float scale;

float pattern(){
	float s = sin(angle), c = cos(angle);
	vec2 texPos = texCoord * u_resolution.xy;
	vec2 point = vec2(
		c * texPos.x - s * texPos.y,
		s * texPos.x + c * texPos.y
	) * scale;
	return (sin(point.x) * sin(point.y)) * 4.0;
}

void main(){
	vec4 color = texture(tex, texCoord);
	float average = (color.r + color.g + color.b) / 3.0;
	fragColor = vec4(vec3(average * 10.0 - 5.0 + pattern()), color.a);
}
