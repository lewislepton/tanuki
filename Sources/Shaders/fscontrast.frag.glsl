#version 450

uniform sampler2D tex;
in vec2 texCoord;
uniform vec2 u_resolution;
uniform float u_time;
out vec4 fragColor;


uniform float angle;
uniform float scale;
uniform float brightness;
uniform float contrast;

void main()
{
    vec4 color = texture(tex, texCoord);
    color.rgb += brightness;

    if (contrast > 0.0)
        color.rgb = (color.rgb - 0.5) / (1.0 - contrast) + 0.5;
    else
        color.rgb = (color.rgb - 0.5) * (1.0 + contrast) + 0.5;
    
    fragColor = color;
}