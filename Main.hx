import h3d.prim.PlanePrim;
import h3d.prim.Primitive;
import h3d.mat.Texture;
import h3d.scene.*;
import h3d.shader.NormalMap;
import hxd.*;
import hxd.Key in K;

class Main extends hxd.App {
	var time:Float = 0.;
	var world:h2d.Layers;
	var y:Int;
	var x:Int;
	var myPointLight:h3d.scene.fwd.PointLight;
	var normalMap:NormalMap;
	var obj:Mesh;
	var light:h3d.scene.fwd.DirLight;
	var lightVec:h3d.Vector;
	var spec:Texture;
	var tex:Texture;
	var z:Float = 0;

	// var prim:h3d.prim.Plane2D;
	public var spr:h2d.Anim;

	override function init() { 
		super.init();

		spec = hxd.Res.spec.toTexture();
		spec.filter = Nearest;
		tex = hxd.Res.diff.toTexture();
		tex.filter = Nearest;

		var prim = new h3d.prim.PlanePrim(1.1, 1.1);

		obj = new Mesh(prim, h3d.mat.Material.create(tex), s3d);
		obj.material.mainPass.enableLights = false;
		obj.material.shadows = false;

		trace("govno");
		// obj.material.mainPass.addShader(new NormalMap(spec));
		obj.rotate(0, 0, 2.35619);

		myPointLight = new h3d.scene.fwd.PointLight(s3d);
		myPointLight.x = x;
		myPointLight.y = y;
		myPointLight.z = 0.2;
		myPointLight.enableSpecular = false;

		s3d.lightSystem.ambientLight.set(0.0, 0.0, 0.0);
		// s3d.camera.pos.set(1,1, 3.9,1);
	}

	override function update(dt:Float) {
		x = Std.int(s2d.mouseX);
		y = Std.int(s2d.mouseY);
		x -= Std.int(s2d.width / 2);
		y -= Std.int(s2d.height / 2);
		myPointLight.x = (y / 200);
		myPointLight.y = (-x / 200);
		if (K.isPressed(K.MOUSE_WHEEL_UP)) {
			z += 1;
			trace(z);
		}
		obj.rotate(0, 0, z);
	}

	static function main() {
		hxd.Res.initEmbed();

		new Main();
	}
}
