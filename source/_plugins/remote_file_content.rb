# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'net/http'
require 'uri'

module Jekyll

  class RemoteFileContent < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      url = markup

      puts 'Fetching content of url: ' + url

      if url =~ URI::regexp
        @content = removeComments(rewriteLinks(fetchContent(url)))
      else
        raise 'Invalid URL passed to RemoteFileContent'
      end

      super
    end

    def render(context)
      if @content
        @content
      else
        raise 'Something went wrong in RemoteFileContent'
      end
    end

    def fetchContent(url)
      Net::HTTP.get(URI.parse(URI.encode(url.strip))).force_encoding("UTF-8").encode("UTF-8")
    end

    def rewriteLinks(c)
      c = c.gsub(/(\[[^\]]*\]\([^:\)]*)\.md\)/, '\1.html)')
    end

    def removeComments(c)
      c = c.sub(/\<\!\-([\s\S]*?)\-\>/, '')
    end

  end
end

Liquid::Template.register_tag('remote_file_content', Jekyll::RemoteFileContent)