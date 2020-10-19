package tanuki.glsl;

import kha.graphics4.VertexShader;
import kha.math.FastVector2;
import kha.graphics4.BlendingFactor;
import kha.Scheduler;
import kha.Canvas;
import kha.graphics4.ConstantLocation;
import kha.graphics4.VertexData;
import kha.Shaders;
import kha.graphics4.VertexStructure;
import kha.graphics4.PipelineState;
import kha.graphics4.FragmentShader;

import tanuki.Body;

class Shader extends Body {
	public var pipeline:PipelineState;

	public var fragmentShader(default, null):FragmentShader;
	public var vertexShader(default, null):VertexShader;
	
	var timeID:ConstantLocation;
	var resolutionID:ConstantLocation;
	var resolution:FastVector2;

	public static var color:Int = 0;
	public static var image:Int = 1;
	public static var text:Int = 2;

	public function new(fragmentShader:FragmentShader, ?vertexShader:VertexShader = null, shadertype:Int, width:Float, height:Float){
		super();
		this.fragmentShader = fragmentShader;
		this.vertexShader = vertexShader;

		pipeline = new PipelineState();
		pipeline.fragmentShader = fragmentShader;

		resolution = new FastVector2(Tanuki.BUFFERWIDTH, Tanuki.BUFFERHEIGHT);

		var structure = new VertexStructure();
		structure.add('vertexPosition', VertexData.Float3);
		switch(shadertype){
			case 0:
				if (vertexShader != null){
					pipeline.vertexShader = vertexShader;
				} else {
					pipeline.vertexShader = Shaders.painter_colored_vert;
				}
				structure.add("vertexColor", VertexData.Float4);

			case 1:
				if (vertexShader != null){
					pipeline.vertexShader = vertexShader;
				} else {
					pipeline.vertexShader = Shaders.painter_image_vert;
				}
				structure.add("texPosition", VertexData.Float2);
				structure.add("vertexColor", VertexData.Float4);

			// case 2:
			// 	pipeline.vertexShader = Shaders.painter_text_vert;
			// 	structure.add("texPosition", VertexData.Float2);
			// 	structure.add("vertexColor", VertexData.Float4);

		default: return;
		}

		pipeline.inputLayout = [structure];

		pipeline.blendSource = BlendingFactor.SourceAlpha;
		pipeline.blendDestination = BlendingFactor.InverseSourceAlpha;
		pipeline.alphaBlendSource = BlendingFactor.SourceAlpha;
		pipeline.alphaBlendDestination = BlendingFactor.InverseSourceAlpha;

		pipeline.compile();

		timeID = pipeline.getConstantLocation('u_time');
		resolutionID = pipeline.getConstantLocation('u_resolution');
	}

	public function begin(canvas:Canvas){
		canvas.g2.pipeline = pipeline;
		pipeline.set();
		canvas.g4.setVector2(resolutionID, resolution);
		canvas.g4.setFloat(timeID, Scheduler.time());
	}

	public function end(canvas:Canvas){
		canvas.g2.pipeline = null;
	}
}