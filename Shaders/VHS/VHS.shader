shader_type canvas_item;

uniform float time = 0;
uniform float strength = 1.0;
uniform bool apply_noise = true;

float rand(vec2 co){
  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
  float amount = 64.0 / strength;
  
  vec2 fragCoord = SCREEN_UV;
  vec4 texColor = vec4(0);
  
  // get position to sample
  vec2 samplePosition = SCREEN_UV;
  float whiteNoise = 9999.0;
  
  // Jitter each line left and right
  samplePosition.x = samplePosition.x+(rand(vec2(time,fragCoord.y))-0.5)/amount;
  // Jitter the whole picture up and down
  samplePosition.y = samplePosition.y+(rand(vec2(time))-0.5)/amount/2.0;
  // Slightly add color noise to each line
  texColor = texColor + (vec4(-0.5)+vec4(rand(vec2(fragCoord.y,time)),rand(vec2(fragCoord.y,time+1.0)),rand(vec2(fragCoord.y,time+2.0)),0))*0.1;
  
  if (apply_noise) {
    // Either sample the texture, or just make the pixel white (to get the staticy-bit at the bottom)
    whiteNoise = rand(vec2(floor(samplePosition.y*80.0),floor(samplePosition.x*50.0))+vec2(time,0));
    if (whiteNoise > 11.5-30.0*samplePosition.y || whiteNoise < 1.5-5.0*samplePosition.y) {
      // Sample the texture.
      // samplePosition.y = 1.0-samplePosition.y; //Fix for upside-down texture
      texColor = texColor + vec4(textureLod(SCREEN_TEXTURE, samplePosition, 0.0).rgb, 1);
    }
    else {
      // Use white. (I'm adding here so the color noise still applies)
      texColor = vec4(1);
    }
  } else {
    texColor = texColor + vec4(textureLod(SCREEN_TEXTURE, samplePosition, 0.0).rgb, 1);
  }
  COLOR = texColor;
}