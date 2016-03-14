numPages = 4

state = -1
numPages++
setInterval () ->
	state++
	
	document.getElementById('mainIndexNumber').style.display = 'none';
	document.getElementById('indexWithBar').style.display = 'none';
	document.getElementById('splashImage').style.display = 'none';
	document.getElementById('breakdown').style.display = 'none';
	document.getElementById('breakdownDetail').style.display = 'none';

	if state % numPages == 0
		document.getElementById('splashImage').style.display = 'block';

	else if state % numPages == 1
		document.getElementById('mainIndexNumber').style.display = 'block';

	else if state % numPages == 2
		document.getElementById('indexWithBar').style.display = 'block';

	else if state % numPages == 3
		document.getElementById('breakdown').style.display = 'block';

	else if state % numPages == 4
		document.getElementById('breakdownDetail').style.display = 'block';


	
, 2000