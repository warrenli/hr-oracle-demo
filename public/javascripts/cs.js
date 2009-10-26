function imgChange(imgName, path) {

	document[imgName].src = path;
}

function showBranch(branch){

	var objBranch = document.getElementById(branch).style;

	if(objBranch.display=="block")
	{
		objBranch.display="none";
	}
	else
	{
		objBranch.display="block";
	}
}


function swapImg(img){

	objImg = document.getElementById(img);

	if(objImg.src.indexOf('node_close.png')>-1)
	{
		objImg.src = "/images/node_open.png";
	}
	else
	{
		objImg.src = "/images/node_close.png";
	}
}

function swapImg2(imgName, path) {

	
	var obj = document.getElementById(imgName)

	obj.src = path;
}
