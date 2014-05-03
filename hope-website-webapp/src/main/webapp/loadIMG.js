
function newImage(arg) {
	if (document.images) {
		rslt = new Image();
		rslt.src = arg;
		return rslt;
	}
}

function changeImages() {
	if (document.images && (preloadFlag == true)) {
		for (var i=0; i<changeImages.arguments.length; i+=2) {
			document[changeImages.arguments[i]].src = changeImages.arguments[i+1];
		}
	}
}

var preloadFlag = false;
function preloadImages() {
	if (document.images) {
		main_02_ImageMap_05_over = newImage("img/main_02-ImageMap_05_over.jpg");
		main_02_ImageMap_06_over = newImage("img/main_02-ImageMap_06_over.jpg");
		main_02_ImageMap_02_over = newImage("img/main_02-ImageMap_02_over.jpg");
		main_02_ImageMap_03_over = newImage("img/main_02-ImageMap_03_over.jpg");
		main_02_ImageMap_04_over = newImage("img/main_02-ImageMap_04_over.jpg");
		preloadFlag = true;
	}
}