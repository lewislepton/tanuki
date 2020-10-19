#version 450

uniform vec2 u_resolution;
uniform float u_time;

// uniform bool u_flipx;
// uniform bool u_flipy;
uniform float u_rotate;
uniform float u_size;
uniform float u_speed;

out vec4 fragColor;

float alpha;

mat2 rotate(float angle){
  return mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
}

void main(){
  vec2 coord = gl_FragCoord.xy / u_resolution;
  vec3 color = vec3(0.0);
 
  float size = u_size;

  if(u_rotate == 180){
    alpha = sin(floor(coord.y * size) - u_time * u_speed) + 1.0 / 2.0;
  } else if (u_rotate == 0) {
    alpha = sin(floor(coord.y * size) + u_time * u_speed) + 1.0 / 2.0;
  } else if(u_rotate == 270){
    alpha = sin(floor(coord.x * size) - u_time * u_speed) + 1.0 / 2.0;
  // } else {
  // }
  } else if (u_rotate == 90){
    alpha = sin(floor(coord.x * size) + u_time * u_speed) + 1.0 / 2.0;
  }

	// coord += vec2(0.5);

  fragColor = vec4(color, alpha);
}