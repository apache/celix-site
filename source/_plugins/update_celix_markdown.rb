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

module Jekyll

  class CelixPage < Page
    def initialize(site, base, dir, name)
      @site = site
      @base = base
      @dir = dir
      @name = name

      full_path = "source/" + dir
      if !full_path.end_with?("/") then
        full_path += "/"
      end
      full_path += name

      file_contents = File.read(full_path, :encoding => 'utf-8')

      if !file_contents.start_with?("---") then
        hdr  = "---\n"
        hdr += "layout: celix-md\n"
        hdr += "title: " + name + "\n"
        hdr += "---\n\n\n"

        edited_file_contents = hdr + file_contents
        out_file = File.new(full_path, "w")
        out_file.puts(edited_file_contents)
        out_file.close
      end

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'celix-md.html')

      self.data['title'] = name

      super
    end
  end

  class CelixPageGenerator < Generator
    safe true

    @@celix_doc_dir = "docs/celix"

    def generate(site)
      if site.layouts.key? 'celix-md'
        celix_dir = site.source + "/" + @@celix_doc_dir
        celix_markdown = File.join(celix_dir + "/**", "*.md")

        Dir.glob(celix_markdown).select{ |e|
          markdown_file = e

          spl = markdown_file.rpartition('/')
          file_name = spl.last()
          splDir = spl.first().rpartition('source/' + @@celix_doc_dir)
          file_dir = splDir.last()

          if file_dir.start_with?("/") then
            file_dir = file_dir[1, file_dir.length - 1]
          end

          file_dir = @@celix_doc_dir + "/" + file_dir

          site.pages << CelixPage.new(site, site.source, file_dir, file_name)
        }
      end
    end
  end

end
