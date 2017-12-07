//make links to the same page unclickable
links = document.getElementsByTagName('a')
url = location.origin + location.pathname
for(i = 0;i < links.length;i++){	
	if(links[i].href == url){
		links[i].style = 'font-weight: bold;pointer-events: none;cursor: default;-webkit-user-select: none;-moz-user-select: none;-ms-user-select: none;user-select: none'
		//add doc anchors
		if(links[i].parentElement.tagName == 'TD'){
			titles = document.getElementsByTagName('h2')
			for(o = 0;o < titles.length;o++){
				titles[o].id = titles[o].innerHTML.replace(/ /g, '_')
				links[i].parentElement.innerHTML += '<br><a style="font-family: timesnewroman;" href="#' + titles[o].id + '">' + titles[o].innerHTML + '</a>'
			}
		}
	}
}
