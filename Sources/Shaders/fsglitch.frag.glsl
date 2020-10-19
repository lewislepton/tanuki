#version 450

in vec2 texCoord;
uniform sampler2D tex;
out vec4 fragColor;

uniform vec2 u_resolution;
uniform float u_time;

float rand(vec2 co){
    return fract(cos(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main(){
   vec3 uv = vec3(0.0);
   vec2 uv2 = vec2(0.0);
   vec2 coord = gl_FragCoord.xy / u_resolution.xy;
   vec3 texColor = vec3(0.0);

  if (rand(vec2(u_time)) < 0.7){
    texColor = texture(tex, texCoord.st).rgb;
  } else{
    texColor = texture(tex, coord * vec2(rand(vec2(u_time)), rand(vec2(u_time * 0.99)))).rgb;
  }
        
  float r = rand(vec2(u_time * 0.001));
  float r2 = rand(vec2(u_time * 0.1));
  if (coord.y > rand(vec2(r2)) && coord.y < r2 + rand(vec2(0.05 * u_time))){
    if (r < rand(vec2(u_time * 0.01))){
      if ((texColor.b + texColor.g + texColor.b)/3.0 < r * rand(vec2(0.4, 0.5)) * 2.0){
        uv.r -= sin(coord.x * r * 0.1 * u_time ) * r * 7000.; 
        uv.g += sin(texCoord.y * texCoord.x/2 * 0.006 * u_time) * r * 10 *rand(vec2(u_time * 0.1)) ;
        uv.b -= sin(coord.y * coord.x * 0.5 * u_time) * sin(coord.y * coord.x * 0.1) * r *  20. ;
        uv2 += vec2(sin(coord.x * r * 0.1 * u_time ) * r ); 
      }
    }
  }

  texColor = texture(tex, texCoord.st + uv2).rgb; 
  texColor += uv;
  fragColor = vec4(texColor, 1.0);  
}