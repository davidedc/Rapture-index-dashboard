
numPages = 4
carouselInterval = 6000

raptureIndexData = {}


# start by only showing the splash image and nothing else
document.getElementById('splashImage').style.display = 'block'
document.getElementById('mainIndexNumber').style.display = 'none'
document.getElementById('indexWithBar').style.display = 'none'
document.getElementById('breakdown').style.display = 'none'
document.getElementById('breakdownDetail').style.display = 'none'
  

numPages--
state = -1

startCarousel = ->
	setInterval () ->

		switchDivs = ->
			console.log state + " " + state % numPages

			document.getElementById('mainIndexNumber').style.display = 'none'
			document.getElementById('indexWithBar').style.display = 'none'
			document.getElementById('splashImage').style.display = 'none'
			document.getElementById('breakdown').style.display = 'none'
			document.getElementById('breakdownDetail').style.display = 'none'

			if state % numPages == 0
				if Math.floor(Math.random() * 2) == 0
					document.getElementById('mainIndexNumber').style.display = 'block'
					jQuery(animatedValue: 0).animate { animatedValue: raptureIndexData.raptureIndexValue },
						duration: 800
						easing: 'swing'
						step: ->
		        			document.getElementById('indexNumber').innerHTML = Math.round @animatedValue
				else
					document.getElementById('indexWithBar').style.display = 'block'
					calculatedPerc = 100 * (raptureIndexData.raptureIndexValue - raptureIndexData.recordLow) / (raptureIndexData.recordHigh - raptureIndexData.recordLow)

					jQuery(perc: 0).animate { perc: calculatedPerc },
						duration: 800
						easing: 'swing'
						step: ->
							document.getElementById('topOfIndicatorBar').style.minHeight = (100-@perc) + "%"
							document.getElementById('bottomOfIndicatorBar').style.minHeight = (@perc) + "%"

					jQuery(animatedValue: 0).animate { animatedValue: raptureIndexData.raptureIndexValue },
						duration: 800
						easing: 'swing'
						step: ->
		        			document.getElementById('currentIndexValueNextToBar').innerHTML = Math.round @animatedValue

			else if state % numPages == 1
				document.getElementById('breakdown').style.display = 'block'
				generatedList = """

	                          <ul class="leaders">
	            """

				if Math.floor(Math.random() * 2) == 0
					lowRange = 0
					highRange = Math.floor raptureIndexData.indexCategories.length/2
				else
					lowRange = Math.floor raptureIndexData.indexCategories.length/2
					highRange = raptureIndexData.indexCategories.length

				for i in [lowRange ... highRange]
					generatedList += "<li><span>" + raptureIndexData.indexCategories[i] + "</span> <span>" + raptureIndexData.categoryValues[i] + "</span></li>"

				generatedList += "                          </ul>"
				document.getElementById('brokenDownList').innerHTML = generatedList

			else if state % numPages == 2
				document.getElementById('breakdownDetail').style.display = 'block'
				whichEntry = Math.floor(Math.random() * (raptureIndexData.indexCategories.length - 1)) + 0
				document.getElementById('breakDownHeader').innerHTML = raptureIndexData.indexCategories[whichEntry]
				document.getElementById('breakDownValue').innerHTML = raptureIndexData.categoryValues[whichEntry]

				otherComments = ""
				for i in [0...raptureIndexData.notesHeadlinesNumbers.length]
					if parseInt(raptureIndexData.notesHeadlinesNumbers[i], 10) == whichEntry + 1
						otherComments = raptureIndexData.notesBodies[i] + "<br>" + "<br>"

				document.getElementById('breakDownComment').innerHTML = otherComments + categoryDescription[whichEntry]
				

			# in
			setTimeout () ->
				$('.perspectiveAnimatable').addClass('rightRotate').removeClass 'leftRotate'
				,1


		state++

		# out
		$('.perspectiveAnimatable').addClass('leftRotate').removeClass 'rightRotate'
		setTimeout switchDivs, 800
		



		
	, carouselInterval


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
        startCarousel()
        raptureIndexData = JSON.parse xmlhttp.responseText

        document.getElementById('highMark').innerHTML = "<b>High: "+ raptureIndexData.recordHigh + "</b> - " + raptureIndexData.highDate
        document.getElementById('lowMark').innerHTML = "<b>Low: "+ raptureIndexData.recordLow + "</b> - " + raptureIndexData.lowDate
        if raptureIndexData.netChange[0] == "+"
        	raptureIndexData.netChange = "▲ " + raptureIndexData.netChange
        else if raptureIndexData.netChange[0] == "+"
        	raptureIndexData.netChange = "▼ " + raptureIndexData.netChange
        document.getElementById('rankChange').innerHTML = raptureIndexData.netChange

        monthNames = [
          'Jan'
          'Feb'
          'Mar'
          'Apr'
          'May'
          'Jun'
          'Jul'
          'Aug'
          'Sep'
          'Oct'
          'Nov'
          'Dec'
        ]
        date = new Date
        day = date.getDate()
        monthIndex = date.getMonth()
        year = date.getFullYear()

        x = document.getElementsByClassName('rightHeaderContent')
        # Find the elements
        i = 0
        while i < x.length
          x[i].innerHTML = day + ' ' + monthNames[monthIndex] + ' ' + year
          # Change the content
          i++

      else if xmlhttp.status == 400
        alert 'There was an error 400'
      else
        alert 'something else other than 200 was returned: ' + xmlhttp.status
    return

  xmlhttp.open 'GET', APIendpointURL, true
  xmlhttp.send()
  return

loadRaptureIndexData('https://rapture-index-cors-api.appspot.com/')

categoryDescription = []
#1. False Christs 
categoryDescription[0] = """
   (Mat.24:24) Jesus talked about false Christs and false prophets. A
   false Christ is anyone who claims to be equal to or greater than God.
   The realization that an individual is placing himself in the role of
   deity is not always easy to discern.
"""
# 2. Occult
categoryDescription[1] = """
    There are two supernatural forces in the universe that are able to
    affect the natural world. God said that prayer is the only valid means
    of getting his attention, and he forbids using occultic devices. Who
    do you think will answer the inquiries using taro cards, astrology,
    or psychic phone lines?
"""
# 3. Satanism 
categoryDescription[2] = """
    Satanism is one of the more difficult categories there is to track.
    It has always been a shadowy topic. The devil's followers are very
    secretive in their actions and cryptic in the writings they publish.
""" 
# 4. Unemployment
categoryDescription[3] = """
    The result of poor economic conditions. Unrest, Crime, and social
    change are effected more by job loss than any other economic factor.
    As warm water is the life blood to the development of a hurricane,
    unemployment is the energy for civil unrest and political upheaval.
"""
# 5. Inflation
categoryDescription[4] = """
    Inflation leads to higher interest rates, unemployment, and the loss
    of buying power. Back in the 20's and 30's the collapse of the German
    government was mostly do to hyper inflation. It was also a major
    factor in the rise of Hitler.
"""
# 6. Interest Rates
categoryDescription[5] = """
    The fluctuation of rates are what steers the economy. When people
    make decisions in the market place, they're unknowingly guided by
    interest rates. The economy will generally move in the same direction 
    the interest rates move.
"""
# 7. The Economy 
categoryDescription[6] = """
    How well an economy is doing determines the stability of a nation.
    History tells that most movements toward war, dictatorship, and 
    Lawlessness is aided by unfavorable financial conditions.
"""
# 8. Oil Supply/Price
categoryDescription[7] = """
    Oil remains an economic and a political issue. We fought The War in
    the Gulf because of petroleum’s strategic importance. The final 
    battle of Armageddon may also involve a dispute over oil.
"""
# 9. Debt and Trade
categoryDescription[8] = """
    In almost all countries there's a ballooning of public and private
    debt. Trade is an underestimated factor in the health of economies.
    The tariffs of the 30's did more mischief than speculators on Wall
    street. As time passes, the economies of the world will become more
    interdependent on each other. Any disruptions in trade could effect
    every nation.
"""
#10. Financial Unrest
categoryDescription[9] = """
    A crash followed by a depression is the most severe economic condition
    a nation can experieince. In almost all occurrences were a country has
    endured economic hardship, social and financial changes have taken
    place. The forces of darkness must be biding their time waiting for
    fiscal despair. Few people realize the downpayments we made on
    enslavement during the last depression, and the seeds we planted
    are soon to reap a harvest of calamity.
"""
#11. Leadership 
categoryDescription[10] = """
    As events transpire it's important to gauge how organized the events
    are. Random happenings may not repeat themselves, while events 
    governed by leadership progress to over come barriers. Leadership 
    could come in the form of a drug cartel funneling drugs into a country, 
    or it could be something like the melting of the ice caps, creating the 
    concern for coastal floods.
"""
#12. Drug Abuse
categoryDescription[11] = """
    (Rev. 9:21) Everyone knows what drugs are today. The Bible also may
     make mention of drugs. In the book of Revelation the word sorcery
     has the Greek word pharmakeia as its root. This is where we get the
     word pharmacy. When it says, "they repented not of their sorceries,"
     it could mean they repented not of their drug use.
"""
#13. Apostasy
categoryDescription[12] = """
    (2 John 1:7) Simple abandoning or defecting from the faith. This can
     come in the form of staying up with the times, a new revelation from
     God, or turning to other religions all together.
"""
#14. Supernatural
categoryDescription[13] = """
    (Rev.13:13-14) When something occurs and science cannot explain it.
     The Bible says during the tribulation, the Antichrist will be able
     to deceive the world through the performance of miracles.
"""
#15. Moral Standards
categoryDescription[14] = """
    This is the fabric which holds our society together. When a state of
    disorder takes over, strong forces are needed to bring back control.
    Civil rights are often the first casualty of this action.
"""
#16. Anti-Christian
categoryDescription[15] = """
    (2 Tim.3:3) A bias or hatred of bible believing Christian. 
    Media are the primary contributors to this category.
"""
#17. Crime Rate
categoryDescription[16] = """
    An insecure society looks for a strongman. As crime proliferates, it
    eats away at the nations moral and economic underpinnings. A nation
    with a high crime rate will eventually have less freedom because of
    the police state the unrest it brings on. High crime rates originates
    from low moral standards.
"""
#18. Ecumenism
categoryDescription[17] = """
    The movement to join all religions into one. This has been a goal of
    the Devil for sometime. By having all religions unified, he could more
    easily control their leadership.
"""
#19. Globalism
categoryDescription[18] = """
    The breaking down of barriers increases the number of alliances, and
    it making the world more integrated.
"""
#20. Tribulation Temple
categoryDescription[19] = """
    (2 Thes.2:3-4),(Dan.9:27) If the Antichrist will sit in God's temple,
    it is logical to conclude the temple must be rebuilt. Daniel foretold
    that he will also stop the daily sacrifice.
"""
#21. Anti-Semitism
categoryDescription[20] = """
    (Rev 12:13) When Satan is cast from heaven, he persecutes the Jewish
    race because through them Jesus was born.
"""
#22. Israel Unrest
categoryDescription[21] = """
    (Zec.12:3) This category tracks the strife in the Israeli state. God
    said, "I will make Jerusalem a burdensome stone for all the people."
    What other city attracts more news coverage than this one? Israel is
    the size of New Jersey, yet it averages the attention of more press 
    than a country the size of Russia.
"""
#23. Russia (Gog)
categoryDescription[22] = """
    (Eze.38-39) Gog is the ancient name for the land of Russia. In the
    last days, Russia will make a move against Israel and be defeated by
    a supernatural act of God.
"""
#24. Persia (Iran)
categoryDescription[23] = """
    (Eze.38:5) Iran will aid Russia in attacking Israel before or during
    the tribulation. Even now, Iran acts as a destabilizing force in the
    world.
"""
#25. False Prophet
categoryDescription[24] = """
    (Rev.13:12) The Antichrist will have a religious leader to aid him.
    The False Prophet will direct the world to worship the Antichrist.
    There has long been a belief that a future pope will have some
    Connection to the designation “false prophet” because of the pope’s 
    great influence. The Antichrist and the False Prophet will be 
    headquartered in the same area As was occupied by the Old Roman Empire.
"""
#26. Nuclear Nations
categoryDescription[25] = """
    (Rev.9:18) The use of nuclear armament during the tribulation will
    kill over 1/3 of the human population. Only in our time –with the 
    nuclear arsenals-- does it seem possible this could happen.
"""
#27. Global Turmoil
categoryDescription[26] = """
    (2 TIM.3:1) There has always been unrest in the world. However, the 
    tremendous level of unrest is unique to our time. Terrorism has been 
    redefined in the twentieth century. Today, more wars take place concurrently
    then at any point in the past.
"""
#28. Arms Proliferation
categoryDescription[27] = """
    (Mat.24:6),(Rev.16:16) Jesus said there would be "wars and rumors of
    wars." The armament trade is not going out of business anytime soon.
    In fact, it will soon supply the biggest conflict in human history,
    the battle of Armageddon.
"""
#29. Liberalism
categoryDescription[28] = """
    It's  not just a part of the Democrat Party. liberalism is what could be
    called the "true conspiracy." Liberal media are 100 percent
    controlled by the forces that bow to humanistic ideology.
"""
#30. Peace Process
categoryDescription[29] = """
    (Dan.9:27) This refers directly to Bible prophecy, where the state
    of Israel signs a peace treaty with the Antichrist.
"""
#31. Kings of the East
categoryDescription[30] = """
    (Rev.9:16),(Dan 11:44) These are the nations of East Asia which
    will send a horde of 200 million soldiers into the Middle East.
"""
#32. Mark of the Beast
categoryDescription[31] = """
    (Rev.13:16) The economic system the Antichrist will implement. It
    will be compulsory, for all, to receive an implant in their right
    hand or forehead.
"""
#33. Beast Government
categoryDescription[32] = """
    (Rev.17:12) The Roman Empire will revive under the leadership of Ten
    rulers. This revived Roman Empire will exist for only 7 years. 
    (Rev.17:13),(Rev 13:5) After the Roman Empire has been revived for 
    3 1/2 years into a seven year rule, the Antichrist will take over and 
    rule for the remaining 3 1/2 years.
"""
#34. The Antichrist
categoryDescription[33] = """
    (Dan.11:36-39) The most evil and destructive man who will ever hold
    public office.
"""
#35. Date Setting
categoryDescription[34] = """
    To create confusion ahead of Christs return, Satan will likely
    continue to motivate people to set dates.  Being exposed to
    date settings, observably makes non-Christians hostile to
    the end-time message.
"""
#36. Volcanoes
categoryDescription[35] = """
    (Mat.24:7) Not mentioned specifically, volcanic eruptions fall into
    the birth pang theme Matthew described. Volcanoes have an ecological
    impact that effects other indicators.
"""
#37. Earthquakes
categoryDescription[36] = """
    Mark 13:8) God used earthquakes to show his disapproval of man’s 
    sinfulness. It is wise to look for more earthquake activity as the 
    return of Christ draws near.
"""
#38. Wild Weather
categoryDescription[37] = """
    (Luke 21:25) The description of the sea and the waves roaring would
    encompass all cyclonic activity.
"""
#39. Civil Rights
categoryDescription[38] = """
    To have a dictator, there must be a shortage of civil rights, and of 
    human rights. The time a people least expect their losing their freedom 
    is when they are willingly giving it up.
"""
#40. Famine
categoryDescription[39] = """
    (Mark 13:8),(Rev.6:6) Famines are a result of drought, a consequence
     of war, or are man made entirely. During the time of the tribulation,
     a days wage will be equal to a loaf of bread.
"""
#41. Drought
categoryDescription[40] = """
    (Mat. 24:7) Another one of the birth pangs Jesus described, drought
    leads to famine or poor economic conditions.
"""
#42. Plagues
categoryDescription[41] = """
    Some Plagues come as a result of man's sin against nature like aids
    while others come as a curse directly from God.
"""
#43. Climate
categoryDescription[42] = """
    (Mat. 24:7) Jesus foretold of an increase in the severity of weather
     events as a sign of the end times. The extremities of nature are
     difficult to measure. Any activity that goes beyond normal weather
     patterns should be taken into consideration, that is, whether God 
     has a warning behind it.
"""
#44. Food Supply
categoryDescription[43] = """
    (Rev.6:6) Historically this has been a volatile indicator. That fact
     that we have been able to keep food production ahead of our booming
     population is not any guarantee of future success. A severe drought
     could disrupt order in small if not large countries.
"""
#45. Floods
categoryDescription[44] = """
   (Gen 6:7) Just like is was in Noah's time, devistateing floods are a
    sign of God's wrath against man's evil ways.   
"""
