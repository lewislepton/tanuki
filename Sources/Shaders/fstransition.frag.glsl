#version 450

uniform sampler2D tex;
in vec2 texCoord;
uniform vec2 u_resolution;
uniform float u_time;
uniform float u_red;
uniform float u_green;
uniform float u_blue;
uniform float u_alpha;
out vec4 fragColor;

void main(){
  vec4 texcolor = texture(tex, texCoord);
  texcolor.r += u_red;
  texcolor.g += u_green;
  texcolor.b += u_blue;
  texcolor.a += u_alpha;

  fragColor = texcolor;
}