import h3d.scene.*;
import h3d.shader.NormalMap;


class Main extends hxd.App {
	var time:Float = 0.;
	var world:h2d.Layers;
	var y:Int;
	var x:Int;
	var myPointLight:h3d.scene.PointLight;
	var normalMap:NormalMap;
	var obj:Mesh;
	var light:h3d.scene.DirLight;
	var lightVec:h3d.Vector;

	public var spr:h2d.Anim;

	override function init() {
		super.init();

		var spec = hxd.Res.spec.toTexture();
		spec.filter = Nearest;
		var tex = hxd.Res.diff.toTexture();
		tex.filter = Nearest;

		var prim = new h3d.prim.Cube(1, 1, 0);
		prim.translate(-0.5, -0.5, -0.5);
		prim.addNormals();
		prim.addUVs();
		prim.addTangents();

		obj = new Mesh(prim, h3d.mat.Material.create(tex), s3d);
		obj.material.mainPass.enableLights = true;
		obj.material.shadows = false;
		obj.material.mainPass.addShader(new NormalMap(spec));
		obj.rotate(0, 0, 1.5708);

		myPointLight = new h3d.scene.PointLight(s3d);
		myPointLight.x = x;
		myPointLight.y = y;
		myPointLight.z = 0.5;
		myPointLight.enableSpecular = true;

		s3d.lightSystem.ambientLight.set(0.3, 0.3, 0.3);
		s3d.camera.pos.set(0, 0, 3.9, 0);
	}

	override function update(dt:Float) {
		x = Std.int(s2d.mouseX);
		y = Std.int(s2d.mouseY);
		x -= Std.int(s2d.width / 2);
		y -= Std.int(s2d.height / 2);
		myPointLight.x = (y / 400);
		myPointLight.y = (-x / 400);
	}

	static function main() {
		hxd.Res.initEmbed();

		new Main();
	}
}
