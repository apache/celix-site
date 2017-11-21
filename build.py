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

import os, inspect, markdown2, shutil, sys

#define urls
markdown = 'src/markdown'
copy = 'src/noprocess'
snippets = 'src'
out = 'site'
celixIndex = 'celix/documentation'
ref = {}

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

#copy to out
if os.path.exists(out):
	shutil.rmtree(out)
shutil.copytree(copy, out)
if not os.path.exists(out):
	os.makedirs(out)

#register site markdown
for f in os.listdir(markdown):
	ref[markdown + '/' + f] = f[:-3] + '.html'
ref[celixIndex + '/index.md'] = 'doc/index.html'

#read index document
with open(celixIndex + '/index.md') as f:
	docT = '<div id=docTable><table>'
	for line in f:
		if(line[0] is '#' and line[1] is '#'):
			if(line[2] != '#'):
				# declares title
				title = line[3:-1].replace(' ', '_')
				docT += '\n\t<tr><th>' + title + '</th></tr>'
			elif(line[3] != '#'):
				# checks if document declaration is valid
				if 'title' not in globals():
					sys.tracebacklimit = 0
					raise NameError("A directory was declared before any title in the index.md file")
				if(not os.path.isdir(out + '/doc/' + title)):
					os.makedirs(out + '/doc/' + title)
				# declares document
				key = celixIndex + '/' + line[line.find('(') + 1:line.find(')')]
				value = 'doc/' + title + '/' + line[line.find('[') + 1:line.find(']')]
				value = value.replace(' ', '_') + '.html'
				# crash when declared document exists
				if key in ref:
					sys.tracebacklimit = 0
					raise NameError('document "' + value + '" was defined multiple times')
				# crash when files cant be reached
				try:
					with open(key) as n:
						try:
							with open(out + '/' + value, 'w') as n:
								# add file to registry
								ref[key] = value
						except IOError:
							sys.tracebacklimit = 0
							raise IOError('coud not read to file "' + out + '/' + ref[key] + '"')
				except IOError:
					sys.tracebacklimit = 0
					raise IOError('could not read file "' + key + '"')
				docT += '\n\t<tr><td><a href=/' + value + '>' + value[5 + len(title):].replace('_', ' ')[:-5] + '</a></td></tr>'
	docT += '\n</table></div>\n'

# write documents
for key in ref:
	try:
		f = open(key)
		o = open(out + '/' + ref[key], 'w')
	except IOError:
		print("failed to convert document: \nsource: " + key + "\ndestination: " + out + '/' + ref[key] + "\ncheck if urls are valid, the source file is readable and the destination is creatable.")
		continue
	file = f.read()
	
	# import other files
	i = 0
	while True:
		i = file.find("{{", i)
		if(i == -1):break
		i2 = file.find("}}", i)
		if(i2 == -1):break
		f2 = open(key[:key.rfind('/') + 1] + file[i + 2:i2])
		file = file[:i] + f2.read() + file[i2 + 2:]
		f2.close()
		i = i2 + 2

	# correct markdown links
	for key2 in ref:
		file = file.replace(combinePaths(key, key2), combinePaths(ref[key], ref[key2]))

	# convert markdown to html, also add top and bottom html files
	file = markdown2.markdown(file, extras=["markdown-in-html"])
	if ref[key].startswith('doc/'):
			file = docT + '<div id=docContent>\n' + file + '\n</div>'
	with open(snippets + '/top.html') as top:
		file = top.read() + file
	with open(snippets + '/bottom.html') as bottom:
		file = file.encode() + bottom.read()
		
	o.write(file)
	f.close()
	o.close()

# run test-server
print('attempting to start a test-server on "http://localhost:8000/"')
os.chdir(out)
if sys.version_info[0] < 3:
	os.system('python -m SimpleHTTPServer 8000')
else:
	os.system('python -m http.server 8000')
