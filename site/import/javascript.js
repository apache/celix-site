//make links to the same page unclickable
links = document.getElementsByTagName('a')
for(i = 0;i < links.length;i++){	
	if(links[i].href == window.location.href){
		links[i].style = 'font-weight: bold;pointer-events: none;cursor: default;-webkit-user-select: none;-moz-user-select: none;-ms-user-select: none;user-select: none'	
	}
}
