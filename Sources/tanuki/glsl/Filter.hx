package tanuki.glsl;

import kha.graphics4.VertexShader;
import kha.graphics4.FragmentShader;
import kha.Image;

class Filter extends Shader {
  static var _image:Image;

  public function new(fragmentShader:FragmentShader, ?vertexShader:VertexShader = null, shadertype:Int, width:Int, height:Int){
    super(fragmentShader, vertexShader, shadertype, width, height);
    if (_image == null){
			_image = Image.createRenderTarget(width, height);
    }
  }
}