function initLightbox(divName)
{
	if (!document.getElementsByTagName){ return; }
	var objBody=document.getElementsByTagName("body").item(0);
	var objOverlay=document.createElement("div");
	objOverlay.setAttribute('id','modal');
	objBody.insertBefore(objOverlay, objBody.firstChild);
	var arrayPageSize=getPageSize();
	var arrayPageScroll=getPageScroll();
	
	//div al centro
	var objLightbox = document.getElementById(divName);
	objBody.insertBefore(objLightbox, objOverlay.nextSibling);
	objOverlay.style.height=(arrayPageSize[1] +300+ 'px');
	objOverlay.style.display='block';
	
	objLightbox.style.width=(arrayPageSize[0]/2.7 + 'px');
	objLightbox.style.left=(arrayPageSize[0]/3.3 + 'px');
	objLightbox.style.height=(arrayPageSize[1]/1.6 + 'px');
	objLightbox.style.top=(arrayPageSize[1]/15 + 'px');
	
	if (navigator.appVersion.indexOf("MSIE")!=-1){
		pause(250);
	}

	/*
	selects = document.getElementsByTagName("select");
	for (i=0; i!=selects.length; i++) {
		selects[i].style.visibility="hidden";
	}
	*/
	
	objLightbox.style.display='block';
	arrayPageSize=getPageSize();
	objOverlay.style.height=(arrayPageSize[1] + 'px');
	
	return false;
}
	
function getPageScroll(){
	var yScroll;
	if (self.pageYOffset) {
		yScroll=self.pageYOffset;
	} else if (document.documentElement && document.documentElement.scrollTop){
		yScroll=document.documentElement.scrollTop;
	} else if (document.body) {
		yScroll=document.body.scrollTop;
	}
	arrayPageScroll=new Array('',yScroll)
	
	return arrayPageScroll;
}

function getPageSize(){
	var xScroll, yScroll;
	if (window.innerHeight && window.scrollMaxY) {
		xScroll=document.body.scrollWidth;
		yScroll=window.innerHeight+window.scrollMaxY;
	} else if (document.body.scrollHeight>document.body.offsetHeight){
		xScroll=document.body.scrollWidth;
		yScroll=document.body.scrollHeight;
	} else {
		xScroll=document.body.offsetWidth;
		yScroll=document.body.offsetHeight;
	}
	var windowWidth, windowHeight;
	if (self.innerHeight) {
		windowWidth=self.innerWidth;
		windowHeight=self.innerHeight;
	} else if (document.documentElement && document.documentElement.clientHeight) {
		windowWidth=document.documentElement.clientWidth;
		windowHeight=document.documentElement.clientHeight;
	} else if (document.body) {
		windowWidth=document.body.clientWidth;
		windowHeight=document.body.clientHeight;
	}
	if(yScroll < windowHeight){
		pageHeight=windowHeight;
	} else {
		pageHeight=yScroll;
	}
	if(xScroll < windowWidth){
		pageWidth=windowWidth;
	} else {
		pageWidth=xScroll;
	}
	arrayPageSize=new Array(pageWidth,pageHeight,windowWidth,windowHeight)
	
	return arrayPageSize;
}

function pause(numberMillis) {
	var now=new Date();
	var exitTime=now.getTime() + numberMillis;
	while (true) {
		now=new Date();
		if (now.getTime() > exitTime)
			return;
	}
}
	
function hideLightbox(divName)
{
	objOverlay=document.getElementById('modal');
	objLightbox=document.getElementById(divName);
	hideObject(objOverlay);
	objLightbox.style.display='none';
	//objOverlay.style.display='none';
	selects = document.getElementsByTagName("select");
	for (i=0; i!=selects.length; i++) {
		if(typeof goFld=="undefined" || selects[i].id!=goFld)
			selects[i].style.visibility="visible";
	}
}

function hideObject(toHide) {
	
	/*
	var count = 4;
	while(count != 0) {
		alert(count);
		setTimeout('alert(toHide);', 500);
		count--;
	}
	*/
	/*
	toHide.style.opacity="0.4";
	sleep(500);
	toHide.style.opacity="0.3";
	sleep(500);
	toHide.style.opacity="0.2";
	sleep(500);
	toHide.style.opacity="0.1";
	sleep(500);
	*/
	toHide.style.display='none';
}