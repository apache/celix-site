/*
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to You under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE- 2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
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
