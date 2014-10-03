/////////////// Set Variables //////////////////
var rotateSpeed = 0.03;
var systemSystemGeo = new THREE.Geometry();
var systemJumpGeo = new THREE.Geometry();
var systemSystem;

/////////////// Create Objects ///////////////////



// Scene
var scene = new THREE.Scene();

// Camera
var camera = new THREE.PerspectiveCamera( 75 , window.innerWidth / window.innerHeight, 0.1, 500000 );
camera.position.y = 1000;
camera.rotation.x = -90;

// renderer
var renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight );
document.body.appendChild( renderer.domElement );

//controls
var control = new THREE.OrbitControls( camera, renderer.domElement );

// Stats
var stats = new Stats();
		stats.domElement.style.position = 'absolute';
		stats.domElement.style.top = '0px';
		document.body.appendChild( stats.domElement );


/////////////// Shaders and Materials ///////////////////
var planetTexture = THREE.ImageUtils.loadTexture( 'images/disc.png' );

var customUniforms =
{
	texture: {type: "t", value: planetTexture },
};

var customAttributes =
{
	customColor: { type: "c", value: [] },
};
				
var vertexShader = "attribute vec3 customColor; varying vec3 vColor; " + 
	"void main(){ vColor = customColor; vec4 mvPosition = modelViewMatrix * vec4( position, 1.0 );" +
	"gl_PointSize = 10.0 * (300.0 / length (mvPosition.xyz ) ); gl_Position = projectionMatrix * mvPosition; }";

var fragmentShader = "uniform sampler2D texture; varying vec3 vColor; void main() { gl_FragColor = vec4 (vColor, 1.0);" +
	"gl_FragColor = gl_FragColor * texture2D ( texture, gl_PointCoord );}";


var systemMat = new THREE.ShaderMaterial (
{
	uniforms: customUniforms,
	attributes: customAttributes,
	vertexShader: document.getElementById( 'vertexshader' ).textContent,
	fragmentShader: document.getElementById( 'fragmentshader' ).textContent,
	transparent: true,
	alphaTest: 0.5
});

var linematerial = new THREE.LineBasicMaterial( { color: 0xcccccc, opacity: 0.4, linewidth: 1 } );


/////////////// Build the Geometry ///////////////////

// Add the Stargate links

for (var jump in jumps){

	var tox, toy, toz, fromx, fromy, fromz;
	
	fromx = system_list[jumps[jump][0]].x;
	fromy = system_list[jumps[jump][0]].y;
	fromz = system_list[jumps[jump][0]].z;
	tox = system_list[jumps[jump][1]].x;
	toy = system_list[jumps[jump][1]].y;
	toz = system_list[jumps[jump][1]].z;
	
	systemJumpGeo.vertices.push(new THREE.Vector3(fromx, fromy, fromz));
	systemJumpGeo.vertices.push(new THREE.Vector3(tox, toy, toz));
}

// Add the Solar Systems

var v = 0;
for (var system in system_list){
	systemSystemGeo.vertices.push(new THREE.Vector3(system_list[system].x, system_list[system].y, system_list[system].z));
	
	var security_level = solarSystemColour(system_list[system].security);
	
	customAttributes.customColor.value[ v ]	=  new THREE.Color(security_level);
	v++;
}

// Add the geometries to the scene

systemSystem = new THREE.ParticleSystem( systemSystemGeo, systemMat );
systemSystem.sortParticles = true;
scene.add(systemSystem);

var line = new THREE.Line( systemJumpGeo, linematerial, THREE.LinePieces );
line.updateMatrix();
scene.add( line );


/////////////// Register Events ///////////////////

window.addEventListener( 'resize', onWindowResize, false );


function solarSystemColour(security)
{
	var value = Number(security);
	
	if(value > 0.9){
		return 0x0404B4;
	}
	else if (value < 0.9 && value >= 0.7){
		return 0x04B404;
	}
	else if (value < 0.7 && value >= 0.5){
		return 0xFFFF00;
	}
	else if (value < 0.5 && value > 0.0){
		return 0xFE9A2E;
	}
	else if(value <= 0.0){
		return 0xFF0000;
	}

}

function animate() {
	requestAnimationFrame( animate );
	stats.update();
	update();
	render();
}

function update() {
	
	updateInput();
}

function updateInput() {
	// kd.tick();

	// 	if (kd.W.isDown()){
	// 		camera.rotation.x += rotateSpeed;
	// 	}

	// 	if (kd.S.isDown()){
	// 		camera.rotation.x -= rotateSpeed;
	// 	}

	// 	if (kd.A.isDown()){
	// 		camera.rotation.y += rotateSpeed;
	// 	}

	// 	if (kd.D.isDown()){
	// 		camera.rotation.y -= rotateSpeed;
	// 	}

	// 	if (kd.Q.isDown()){
	// 		camera.rotation.z -= rotateSpeed;
	// 	}

	// 	if (kd.E.isDown()){
	// 		camera.rotation.z += rotateSpeed;
	// 	}
	var dt = 10;
	control.update(dt);
}

function render() {
	renderer.render(scene, camera);
}

function onWindowResize() {
	camera.aspect = window.innerWidth / window.innerHeight;
	camera.updateProjectionMatrix();
	renderer.setSize (window.innerWidth, window.innerHeight);
}

animate();