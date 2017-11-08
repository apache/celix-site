#!/usr/bin/env python
import os, inspect, markdown2, shutil

#define urls
markdown = 'src/markdown'
copy = 'src/noprocess'
celix = 'celix'
snippets = 'src'
out = 'site'

#copy to out
if os.path.exists(out):
	shutil.rmtree(out)
shutil.copytree(copy, out)
if not os.path.exists(out):
	os.makedirs(out)

#process markdown files
for f in os.listdir(markdown):
	with open(out + '/' + f[:-2] + 'html', 'w') as html:
		with open(snippets + '/top.html') as top:
			html.write(top.read())
		with open(markdown + '/' + f) as md:
			html.write(markdown2.markdown(md.read(), extras=["markdown-in-html"]))
		with open(snippets + '/bottom.html') as bottom:
			html.write(bottom.read())
