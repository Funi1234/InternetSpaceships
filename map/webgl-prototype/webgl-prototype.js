/////////////// Set Variables //////////////////
var rotateSpeed = 0.03;
var scaleDivisor = Number("1e15");
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


/////////////// Create Geometry ///////////////////
var planetTexture = THREE.ImageUtils.loadTexture( 'images/disc.png' );
var customUniforms =
{
	texture: {type: "t", value: planetTexture },
};

var customAttributes =
{
	customColor: { type: "c", value: [] },
};

//lines
var linematerial = new THREE.LineBasicMaterial( { color: 0xcccccc, opacity: 0.4, linewidth: 1 } );


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


var v = 0;
for (var system in system_list){
	systemSystemGeo.vertices.push(new THREE.Vector3(Number(system_list[system].x), Number(system_list[system].y), Number(system_list[system].z)));
	customAttributes.customColor.value[ v ]	= new THREE.Color( v * 10000 );
	v++;
}


var systemMat = new THREE.ShaderMaterial (
	{
		uniforms: customUniforms,
		attributes: customAttributes,
		vertexShader: document.getElementById( 'vertexshader' ).textContent,
		fragmentShader: document.getElementById( 'fragmentshader' ).textContent,
		transparent: true,
		alphaTest: 0.5
	});


var line = new THREE.Line( systemJumpGeo, linematerial, THREE.LinePieces );
line.updateMatrix();
scene.add( line );

systemSystem = new THREE.ParticleSystem( systemSystemGeo, systemMat );
systemSystem.sortParticles = true;
scene.add(systemSystem);


/////////////// Register Events ///////////////////

window.addEventListener( 'resize', onWindowResize, false );


function animate() {
	requestAnimationFrame( animate );

	update();

	render();
}

function update() {
	stats.update();

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