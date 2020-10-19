#version 450

uniform sampler2D tex;
in vec2 texCoord;
uniform vec2 u_resolution;
uniform float u_time;
out vec4 fragColor;


uniform float angle;
uniform float scale;

uniform float amount;

float rand(vec2 co){
  return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main(){
  vec4 color = texture(tex, texCoord);
  float diff = (rand(texCoord) - 0.5) * amount;
  color.r += diff;
  color.g += diff;
  color.b += diff;
  fragColor = color;
}