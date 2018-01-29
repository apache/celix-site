#!/usr/bin/env python

#    Licensed to the Apache Software Foundation (ASF) under one or more
#    contributor license agreements.  See the NOTICE file distributed with
#    this work for additional information regarding copyright ownership.
#    The ASF licenses this file to You under the Apache License, Version 2.0
#    (the "License"); you may not use this file except in compliance with
#    the License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE- 2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

__author__ = "Edwin Smink"
__copyright__ = "Copyright 2011 The Apache Software Foundation"
__license__ = "Apache-2.0"
__version__ = "1.0.0"

import os, inspect, markdown2, shutil, sys, xml.etree.ElementTree as ET

#define urls
markdown = 'src/markdown'
copy = 'src/noprocess'
snippets = 'src'
out = 'site'
docIndex = 'docTableIndex.xml'

#combines two paths to files from a common root directory
#to a path from the parent directory of file one to file two
def combinePaths(one, two):
	if(one is two):
		return ""
	one = one.split('/')
	two = two.split('/')
	i = 0
	segment = ""
	#detect how much of the paths are equal then start writing the new path
	while(len(one) > i and len(two) > i and one[i] == two[i]):i += 1
	for x in one[i:-1]: segment += "../"
	for x in two[i:]: segment += x + '/'
	return segment[:-1]

# tries removing all the ../ in a path
def normalizePath(path):
	path = path.split('/')
	answer = ""
	for x in path:
		if(x == '..'):answer = answer[0:answer.rfind('/')]
		else:answer += '/' + x
	return answer[1:len(answer)]

#copy to out
if os.path.exists(out):
	shutil.rmtree(out)
shutil.copytree(copy, out)
if not os.path.exists(out):
	os.makedirs(out)

# read index document
root = ET.parse(docIndex).getroot()
for title in root:
	for fl in title:	
		fl.append(ET.fromstring('<dest>' + out + '/doc/' + (title.attrib['name'] + '/' + fl.attrib['name']).replace(' ', '_') + '.html</dest>'))

# create doctable
docT = '<table id=docTable class=shadowed>'
for title in root:
	docT += '\n\t<tr><th>' + title.attrib['name'] + '</th></tr>'
	for fl in title:
		docT += '\n\t<tr><td><a href=/' + fl.find('dest').text[len(out) + 1:] + '>' + fl.attrib['name'] + '</a></td></tr>'
docT = docT.replace('/index.html', '/') + '\n</table>\n'

#register site markdown
md = ''
for f in os.listdir(markdown):
	md += '<file><path>' + markdown + '/' + f + '</path><dest>site/' + f[:-3].replace(' ', '_') + '.html</dest></file>'
root.append(ET.fromstring('<markdown>' + md + '</markdown>'))
root.append(ET.fromstring('<importurl></importurl>'))

imported = []
for title in root:
	for fl in title:
		imported.append(fl.find('path').text)

# write documents
for title in root:
	for fl in title:
		try:os.makedirs(fl.find('dest').text[0:fl.find('dest').text.rfind('/')])
		except: IOError
		with open(fl.find('path').text) as f:file = f.read()
		o = open(fl.find('dest').text, 'w')

		# import url
		i = 0
		if(fl.find('dest').text.startswith('site/doc/')):
			while True:
				i = file.find('[', i)
				if(i == -1):break
				i2 = file.find('(', i)
				if(i2 == -1):break
				i3 = file.find(')', i2)
				if(i3 == -1):break
				if(file.find('\n', i, i3) != -1 or file.startswith('(http', i2)):
					i += 3
					continue

				url = normalizePath(fl.find('path').text[fl.find('path').text.find('/'):fl.find('path').text.rfind('/') + 1] + file[i2 + 1:i3])
				if('celix' + url not in imported):
					imported.append('celix' + url)
					# found new url
					try:
						with open('celix' + url) as src:
							# add url to markdown processing
							if(url[-3:len(url)] == '.md'):
								root.find('importurl').append(ET.fromstring('<file><path>celix' + url + '</path><dest>site/doc/noIndex' + url[0:-3] + '.html</dest></file>'))
								file = file[0:i2 + 1] + '/doc/noIndex' + url[0:-3] + '.html' + file[i3:len(file)]
							# add url to files
							else:
								try:os.makedirs('site/doc/noIndex' + url[0:url.rfind('/')])
								except: IOError
								with open('site/doc/noIndex' + url, 'w') as dest:dest.write(src.read())
								file = file[0:i2 + 1] + '/doc/noIndex' + url + file[i3:len(file)]
					except IOError:
						print('ERROR: could not find file: "celix' + url + '" referenced in file: ' + fl.find('path').text)
				i = i3

		# import other files
		if fl.find('url'):
			i = 0
			url = fl.find('url').text.split('url')
			while True:
				i = file.find(url[0], i)
				if(i == -1):break
				i2 = file.find(url[1], i)
				if(i2 == -1):break
				f2 = open(key[:key.rfind('/') + 1] + file[i + len(url[0]):i2])
				file = file[:i] + f2.read() + file[i2 + len(url[1]):]
				f2.close()
				i = i2 + 2

			# correct markdown links
			file = file.replace(combinePaths(fl.find('path').text,fl2.find('path').text), combinePaths(fl.find('dest').text, fl2.find('dest').text))

		# convert markdown to html, also add top and bottom html files
		file = markdown2.markdown(file, extras=["markdown-in-html", "break-on-newline", "fenced-code-blocks"])
		if(title.tag != 'markdown'):
				file = docT + '<div id=docContent>\n' + file + '\n</div>'
		with open(snippets + '/top.html') as top:
			file = top.read() + file
		with open(snippets + '/bottom.html') as bottom:
			file = file.encode('utf8') + bottom.read()

		o.write(file)
		o.close()

# run test-server
print('attempting to start a test-server on "http://localhost:8000/"')
os.chdir(out)
if sys.version_info[0] < 3:
	os.system('python -m SimpleHTTPServer 8000')
else:
	os.system('python -m http.server 8000')
