// Generated by CoffeeScript 1.10.0
var carouselInterval, carouselIsOngoing, categoryDescription, endpointURL, loadRaptureIndexData, numPages, raptureIndexData, startCarousel, state;

numPages = 4;

carouselInterval = 6000;

raptureIndexData = {};

document.getElementById('splashImage').style.display = 'block';

document.getElementById('mainIndexNumber').style.display = 'none';

document.getElementById('indexWithBar').style.display = 'none';

document.getElementById('breakdown').style.display = 'none';

document.getElementById('breakdownDetail').style.display = 'none';

numPages--;

state = -1;

carouselIsOngoing = false;

startCarousel = function() {
  carouselIsOngoing = true;
  return setInterval(function() {
    var switchDivs;
    switchDivs = function() {
      var calculatedPerc, generatedList, highRange, i, j, k, lowRange, otherComments, ref, ref1, ref2, whichEntry;
      console.log(state + " " + state % numPages);
      document.getElementById('mainIndexNumber').style.display = 'none';
      document.getElementById('indexWithBar').style.display = 'none';
      document.getElementById('splashImage').style.display = 'none';
      document.getElementById('breakdown').style.display = 'none';
      document.getElementById('breakdownDetail').style.display = 'none';
      if (state % numPages === 0) {
        if (Math.floor(Math.random() * 2) === 0) {
          document.getElementById('mainIndexNumber').style.display = 'block';
          jQuery({
            animatedValue: 0
          }).animate({
            animatedValue: raptureIndexData.raptureIndexValue
          }, {
            duration: 800,
            easing: 'swing',
            step: function() {
              return document.getElementById('indexNumber').innerHTML = Math.round(this.animatedValue);
            }
          });
        } else {
          document.getElementById('indexWithBar').style.display = 'block';
          calculatedPerc = 100 * (raptureIndexData.raptureIndexValue - raptureIndexData.recordLow) / (raptureIndexData.recordHigh - raptureIndexData.recordLow);
          jQuery({
            perc: 0
          }).animate({
            perc: calculatedPerc
          }, {
            duration: 800,
            easing: 'swing',
            step: function() {
              document.getElementById('topOfIndicatorBar').style.minHeight = (100 - this.perc) + "%";
              return document.getElementById('bottomOfIndicatorBar').style.minHeight = this.perc + "%";
            }
          });
          jQuery({
            animatedValue: 0
          }).animate({
            animatedValue: raptureIndexData.raptureIndexValue
          }, {
            duration: 800,
            easing: 'swing',
            step: function() {
              return document.getElementById('currentIndexValueNextToBar').innerHTML = Math.round(this.animatedValue);
            }
          });
        }
      } else if (state % numPages === 1) {
        document.getElementById('breakdown').style.display = 'block';
        generatedList = "\n<ul class=\"leaders\">";
        if (Math.floor(Math.random() * 2) === 0) {
          lowRange = 0;
          highRange = Math.floor(raptureIndexData.indexCategories.length / 2);
        } else {
          lowRange = Math.floor(raptureIndexData.indexCategories.length / 2);
          highRange = raptureIndexData.indexCategories.length;
        }
        for (i = j = ref = lowRange, ref1 = highRange; ref <= ref1 ? j < ref1 : j > ref1; i = ref <= ref1 ? ++j : --j) {
          generatedList += "<li><span>" + raptureIndexData.indexCategories[i] + "</span> <span>" + raptureIndexData.categoryValues[i] + "</span></li>";
        }
        generatedList += "                          </ul>";
        document.getElementById('brokenDownList').innerHTML = generatedList;
      } else if (state % numPages === 2) {
        document.getElementById('breakdownDetail').style.display = 'block';
        whichEntry = Math.floor(Math.random() * (raptureIndexData.indexCategories.length - 1)) + 0;
        document.getElementById('breakDownHeader').innerHTML = raptureIndexData.indexCategories[whichEntry];
        document.getElementById('breakDownValue').innerHTML = raptureIndexData.categoryValues[whichEntry];
        otherComments = "";
        for (i = k = 0, ref2 = raptureIndexData.notesHeadlinesNumbers.length; 0 <= ref2 ? k < ref2 : k > ref2; i = 0 <= ref2 ? ++k : --k) {
          if (parseInt(raptureIndexData.notesHeadlinesNumbers[i], 10) === whichEntry + 1) {
            otherComments = raptureIndexData.notesBodies[i] + "<br>" + "<br>";
          }
        }
        document.getElementById('breakDownComment').innerHTML = otherComments + categoryDescription[whichEntry];
      }
      return setTimeout(function() {
        return $('.perspectiveAnimatable').addClass('rightRotate').removeClass('leftRotate', 1);
      });
    };
    state++;
    $('.perspectiveAnimatable').addClass('leftRotate').removeClass('rightRotate');
    return setTimeout(switchDivs, 800);
  }, carouselInterval);
};

loadRaptureIndexData = function(APIendpointURL) {
  var xmlhttp;
  xmlhttp = void 0;
  if (window.XMLHttpRequest) {
    xmlhttp = new XMLHttpRequest;
  } else {
    xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
  }
  xmlhttp.onreadystatechange = function() {
    var date, day, i, monthIndex, monthNames, x, year;
    if (xmlhttp.readyState === XMLHttpRequest.DONE) {
      if (xmlhttp.status === 200) {
        if (!carouselIsOngoing) {
          startCarousel();
        }
        raptureIndexData = JSON.parse(xmlhttp.responseText);
        document.getElementById('highMark').innerHTML = "<b>High: " + raptureIndexData.recordHigh + "</b> - " + raptureIndexData.highDate;
        document.getElementById('lowMark').innerHTML = "<b>Low: " + raptureIndexData.recordLow + "</b> - " + raptureIndexData.lowDate;
        if (raptureIndexData.netChange[0] === "+") {
          raptureIndexData.netChange = "▲ " + raptureIndexData.netChange;
        } else if (raptureIndexData.netChange[0] === "-") {
          raptureIndexData.netChange = "▼ " + raptureIndexData.netChange;
        }
        document.getElementById('rankChange').innerHTML = raptureIndexData.netChange;
        monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        date = new Date;
        day = date.getDate();
        monthIndex = date.getMonth();
        year = date.getFullYear();
        x = document.getElementsByClassName('rightHeaderContent');
        i = 0;
        while (i < x.length) {
          x[i].innerHTML = day + ' ' + monthNames[monthIndex] + ' ' + year;
          i++;
        }
      } else if (xmlhttp.status === 400) {
        if (!carouselIsOngoing) {
          alert('There was an error 400');
        } else {
          console.log('There was an error 400');
        }
      } else {
        if (!carouselIsOngoing) {
          alert('something else other than 200 was returned: ' + xmlhttp.status);
        } else {
          console.log('something else other than 200 was returned: ' + xmlhttp.status);
        }
      }
    }
  };
  xmlhttp.open('GET', APIendpointURL, true);
  xmlhttp.send();
};

endpointURL = 'https://rapture-index-cors-api.appspot.com/';

loadRaptureIndexData(endpointURL);

setInterval(function() {
  return loadRaptureIndexData(endpointURL);
}, 1000 * 60 * 30);

categoryDescription = [];

categoryDescription[0] = "(Mat.24:24) Jesus talked about false Christs and false prophets. A\nfalse Christ is anyone who claims to be equal to or greater than God.\nThe realization that an individual is placing himself in the role of\ndeity is not always easy to discern.";

categoryDescription[1] = "There are two supernatural forces in the universe that are able to\naffect the natural world. God said that prayer is the only valid means\nof getting his attention, and he forbids using occultic devices. Who\ndo you think will answer the inquiries using taro cards, astrology,\nor psychic phone lines?";

categoryDescription[2] = "Satanism is one of the more difficult categories there is to track.\nIt has always been a shadowy topic. The devil's followers are very\nsecretive in their actions and cryptic in the writings they publish.";

categoryDescription[3] = "The result of poor economic conditions. Unrest, Crime, and social\nchange are effected more by job loss than any other economic factor.\nAs warm water is the life blood to the development of a hurricane,\nunemployment is the energy for civil unrest and political upheaval.";

categoryDescription[4] = "Inflation leads to higher interest rates, unemployment, and the loss\nof buying power. Back in the 20's and 30's the collapse of the German\ngovernment was mostly do to hyper inflation. It was also a major\nfactor in the rise of Hitler.";

categoryDescription[5] = "The fluctuation of rates are what steers the economy. When people\nmake decisions in the market place, they're unknowingly guided by\ninterest rates. The economy will generally move in the same direction \nthe interest rates move.";

categoryDescription[6] = "How well an economy is doing determines the stability of a nation.\nHistory tells that most movements toward war, dictatorship, and \nLawlessness is aided by unfavorable financial conditions.";

categoryDescription[7] = "Oil remains an economic and a political issue. We fought The War in\nthe Gulf because of petroleum’s strategic importance. The final \nbattle of Armageddon may also involve a dispute over oil.";

categoryDescription[8] = "In almost all countries there's a ballooning of public and private\ndebt. Trade is an underestimated factor in the health of economies.\nThe tariffs of the 30's did more mischief than speculators on Wall\nstreet. As time passes, the economies of the world will become more\ninterdependent on each other. Any disruptions in trade could effect\nevery nation.";

categoryDescription[9] = "A crash followed by a depression is the most severe economic condition\na nation can experieince. In almost all occurrences were a country has\nendured economic hardship, social and financial changes have taken\nplace. The forces of darkness must be biding their time waiting for\nfiscal despair. Few people realize the downpayments we made on\nenslavement during the last depression, and the seeds we planted\nare soon to reap a harvest of calamity.";

categoryDescription[10] = "As events transpire it's important to gauge how organized the events\nare. Random happenings may not repeat themselves, while events \ngoverned by leadership progress to over come barriers. Leadership \ncould come in the form of a drug cartel funneling drugs into a country, \nor it could be something like the melting of the ice caps, creating the \nconcern for coastal floods.";

categoryDescription[11] = "(Rev. 9:21) Everyone knows what drugs are today. The Bible also may\n make mention of drugs. In the book of Revelation the word sorcery\n has the Greek word pharmakeia as its root. This is where we get the\n word pharmacy. When it says, \"they repented not of their sorceries,\"\n it could mean they repented not of their drug use.";

categoryDescription[12] = "(2 John 1:7) Simple abandoning or defecting from the faith. This can\n come in the form of staying up with the times, a new revelation from\n God, or turning to other religions all together.";

categoryDescription[13] = "(Rev.13:13-14) When something occurs and science cannot explain it.\n The Bible says during the tribulation, the Antichrist will be able\n to deceive the world through the performance of miracles.";

categoryDescription[14] = "This is the fabric which holds our society together. When a state of\ndisorder takes over, strong forces are needed to bring back control.\nCivil rights are often the first casualty of this action.";

categoryDescription[15] = "(2 Tim.3:3) A bias or hatred of bible believing Christian. \nMedia are the primary contributors to this category.";

categoryDescription[16] = "An insecure society looks for a strongman. As crime proliferates, it\neats away at the nations moral and economic underpinnings. A nation\nwith a high crime rate will eventually have less freedom because of\nthe police state the unrest it brings on. High crime rates originates\nfrom low moral standards.";

categoryDescription[17] = "The movement to join all religions into one. This has been a goal of\nthe Devil for sometime. By having all religions unified, he could more\neasily control their leadership.";

categoryDescription[18] = "The breaking down of barriers increases the number of alliances, and\nit making the world more integrated.";

categoryDescription[19] = "(2 Thes.2:3-4),(Dan.9:27) If the Antichrist will sit in God's temple,\nit is logical to conclude the temple must be rebuilt. Daniel foretold\nthat he will also stop the daily sacrifice.";

categoryDescription[20] = "(Rev 12:13) When Satan is cast from heaven, he persecutes the Jewish\nrace because through them Jesus was born.";

categoryDescription[21] = "(Zec.12:3) This category tracks the strife in the Israeli state. God\nsaid, \"I will make Jerusalem a burdensome stone for all the people.\"\nWhat other city attracts more news coverage than this one? Israel is\nthe size of New Jersey, yet it averages the attention of more press \nthan a country the size of Russia.";

categoryDescription[22] = "(Eze.38-39) Gog is the ancient name for the land of Russia. In the\nlast days, Russia will make a move against Israel and be defeated by\na supernatural act of God.";

categoryDescription[23] = "(Eze.38:5) Iran will aid Russia in attacking Israel before or during\nthe tribulation. Even now, Iran acts as a destabilizing force in the\nworld.";

categoryDescription[24] = "(Rev.13:12) The Antichrist will have a religious leader to aid him.\nThe False Prophet will direct the world to worship the Antichrist.\nThere has long been a belief that a future pope will have some\nConnection to the designation “false prophet” because of the pope’s \ngreat influence. The Antichrist and the False Prophet will be \nheadquartered in the same area As was occupied by the Old Roman Empire.";

categoryDescription[25] = "(Rev.9:18) The use of nuclear armament during the tribulation will\nkill over 1/3 of the human population. Only in our time –with the \nnuclear arsenals-- does it seem possible this could happen.";

categoryDescription[26] = "(2 TIM.3:1) There has always been unrest in the world. However, the \ntremendous level of unrest is unique to our time. Terrorism has been \nredefined in the twentieth century. Today, more wars take place concurrently\nthen at any point in the past.";

categoryDescription[27] = "(Mat.24:6),(Rev.16:16) Jesus said there would be \"wars and rumors of\nwars.\" The armament trade is not going out of business anytime soon.\nIn fact, it will soon supply the biggest conflict in human history,\nthe battle of Armageddon.";

categoryDescription[28] = "It's  not just a part of the Democrat Party. liberalism is what could be\ncalled the \"true conspiracy.\" Liberal media are 100 percent\ncontrolled by the forces that bow to humanistic ideology.";

categoryDescription[29] = "(Dan.9:27) This refers directly to Bible prophecy, where the state\nof Israel signs a peace treaty with the Antichrist.";

categoryDescription[30] = "(Rev.9:16),(Dan 11:44) These are the nations of East Asia which\nwill send a horde of 200 million soldiers into the Middle East.";

categoryDescription[31] = "(Rev.13:16) The economic system the Antichrist will implement. It\nwill be compulsory, for all, to receive an implant in their right\nhand or forehead.";

categoryDescription[32] = "(Rev.17:12) The Roman Empire will revive under the leadership of Ten\nrulers. This revived Roman Empire will exist for only 7 years. \n(Rev.17:13),(Rev 13:5) After the Roman Empire has been revived for \n3 1/2 years into a seven year rule, the Antichrist will take over and \nrule for the remaining 3 1/2 years.";

categoryDescription[33] = "(Dan.11:36-39) The most evil and destructive man who will ever hold\npublic office.";

categoryDescription[34] = "To create confusion ahead of Christs return, Satan will likely\ncontinue to motivate people to set dates.  Being exposed to\ndate settings, observably makes non-Christians hostile to\nthe end-time message.";

categoryDescription[35] = "(Mat.24:7) Not mentioned specifically, volcanic eruptions fall into\nthe birth pang theme Matthew described. Volcanoes have an ecological\nimpact that effects other indicators.";

categoryDescription[36] = "Mark 13:8) God used earthquakes to show his disapproval of man’s \nsinfulness. It is wise to look for more earthquake activity as the \nreturn of Christ draws near.";

categoryDescription[37] = "(Luke 21:25) The description of the sea and the waves roaring would\nencompass all cyclonic activity.";

categoryDescription[38] = "To have a dictator, there must be a shortage of civil rights, and of \nhuman rights. The time a people least expect their losing their freedom \nis when they are willingly giving it up.";

categoryDescription[39] = "(Mark 13:8),(Rev.6:6) Famines are a result of drought, a consequence\n of war, or are man made entirely. During the time of the tribulation,\n a days wage will be equal to a loaf of bread.";

categoryDescription[40] = "(Mat. 24:7) Another one of the birth pangs Jesus described, drought\nleads to famine or poor economic conditions.";

categoryDescription[41] = "Some Plagues come as a result of man's sin against nature like aids\nwhile others come as a curse directly from God.";

categoryDescription[42] = "(Mat. 24:7) Jesus foretold of an increase in the severity of weather\n events as a sign of the end times. The extremities of nature are\n difficult to measure. Any activity that goes beyond normal weather\n patterns should be taken into consideration, that is, whether God \n has a warning behind it.";

categoryDescription[43] = "(Rev.6:6) Historically this has been a volatile indicator. That fact\n that we have been able to keep food production ahead of our booming\n population is not any guarantee of future success. A severe drought\n could disrupt order in small if not large countries.";

categoryDescription[44] = "(Gen 6:7) Just like is was in Noah's time, devistateing floods are a\n sign of God's wrath against man's evil ways.   ";

//# sourceMappingURL=main.js.map
