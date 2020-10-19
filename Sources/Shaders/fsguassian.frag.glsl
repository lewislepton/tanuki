#version 450

in vec2 texCoord;
uniform sampler2D tex;
out vec4 fragColor;

uniform vec2 u_resolution;
uniform float u_time;

uniform vec2 direction;
uniform bool flip;

vec4 blur(sampler2D tex, vec2 coord, vec2 resolution, vec2 direction){
  // vec4 color = vec4(0.0);
  // vec2 off1 = vec2(1.3333333333333333) * direction;
  // color += texture(tex, coord) * 0.29411764705882354;
  // color += texture(tex, coord + (off1 / resolution)) * 0.35294117647058826;
  // color += texture(tex, coord - (off1 / resolution)) * 0.35294117647058826;
  // return color;
  vec4 color = vec4(0.0);
  vec2 off1 = vec2(1.3846153846) * direction;
  vec2 off2 = vec2(3.2307692308) * direction;
  color += texture(tex, coord) * 0.2270270270;
  color += texture(tex, coord + (off1 / resolution)) * 0.3162162162;
  color += texture(tex, coord - (off1 / resolution)) * 0.3162162162;
  color += texture(tex, coord + (off2 / resolution)) * 0.0702702703;
  color += texture(tex, coord - (off2 / resolution)) * 0.0702702703;
  return color;
}

void main(){
  vec2 coord = (gl_FragCoord.xy / u_resolution);
  if (flip) {
    coord.y = 1.0 - coord.y;
  }
  fragColor = blur(tex, coord, u_resolution.xy, direction);
}