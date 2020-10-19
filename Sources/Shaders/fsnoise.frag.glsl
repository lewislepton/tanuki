#version 450

uniform vec2 u_resolution;
uniform float u_time;

out vec4 fragColor;

float noise1d(float value){
  return cos(value + cos(value * 90.0) * 100.0) * 0.5 + 0.5;
}

void main(){
  vec2 coord = gl_FragCoord.xy;
  vec3 color = vec3(0.0);

  color += noise1d(u_time);

  fragColor = vec4(color, 1.0);
}