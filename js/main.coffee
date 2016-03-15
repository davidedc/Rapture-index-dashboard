
STATE_LOADING = 0
STATE_SHOWING_PAGE = 1

ANIM_STATE_IN = 0
ANIM_STATE_NONE = 1
ANIM_STATE_OUT = 2

numPages = 4


$('#animator').on 'mouseover', ->
  $('.perspectiveAnimatable').addClass('leftRotate').removeClass 'rightRotate'

$('#animator').on 'mouseout', ->
  


state = -1
animState = ANIM_STATE_IN

numPages++
setInterval () ->

	switchDivs = ->
		console.log state + " " + state % numPages

		document.getElementById('mainIndexNumber').style.display = 'none'
		document.getElementById('indexWithBar').style.display = 'none'
		document.getElementById('splashImage').style.display = 'none'
		document.getElementById('breakdown').style.display = 'none'
		document.getElementById('breakdownDetail').style.display = 'none'

		if state % numPages == 0
			document.getElementById('splashImage').style.display = 'block'

		else if state % numPages == 1
			document.getElementById('mainIndexNumber').style.display = 'block'

		else if state % numPages == 2
			document.getElementById('indexWithBar').style.display = 'block'

		else if state % numPages == 3
			document.getElementById('breakdown').style.display = 'block'

		else if state % numPages == 4
			document.getElementById('breakdownDetail').style.display = 'block'

		# in
		setTimeout () ->
			$('.perspectiveAnimatable').addClass('rightRotate').removeClass 'leftRotate'
			,1


	state++

	# out
	$('.perspectiveAnimatable').addClass('leftRotate').removeClass 'rightRotate'
	setTimeout switchDivs, 800
	



	
, 2000


loadRaptureIndexData = (APIendpointURL) ->
  xmlhttp = undefined
  if window.XMLHttpRequest
    # code for IE7+, Firefox, Chrome, Opera, Safari
    xmlhttp = new XMLHttpRequest
  else
    # code for IE6, IE5
    xmlhttp = new ActiveXObject('Microsoft.XMLHTTP')

  xmlhttp.onreadystatechange = ->
    if xmlhttp.readyState == XMLHttpRequest.DONE
      if xmlhttp.status == 200
        console.log xmlhttp.responseText
      else if xmlhttp.status == 400
        alert 'There was an error 400'
      else
        alert 'something else other than 200 was returned'
    return

  xmlhttp.open 'GET', APIendpointURL, true
  xmlhttp.send()
  return

loadRaptureIndexData('https://rapture-index-cors-api.appspot.com/')