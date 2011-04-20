# Copyright 2011 ThoughtWorks, Inc. Licensed under the MIT License
module Cuporter
  module Document
    module Html

      def add_report(report_node)
        root << head(report_node['title'])
        root << report_node
      end

      def to_html(options = {})
        root.at(:head).to_html + root.at(:body).to_xml(options)
      end

      private

      def head(title_text)
        h = new_node(:head)
        title = new_node(:title)
        title.content = title_text
        h << title
        h << inline_css("cuporter.css")
        h << inline_css("#{view}_style.css")
        h << inline_js("jquery-min.js")
        h << inline_js("expand-collapse.js")
        h
      end

      def assets_dir
        @assets_dir ||= File.expand_path('formatter', File.dirname(__FILE__) + "/../")
      end
      def inline_css(style_sheet)
        style = new_node('style', 'type' => 'text/css')
        file = "#{assets_dir}/#{style_sheet}"
        style.content = "\n#{File.read(file)}"
        style
      end

      def inline_js(js_file)
        script = new_node('script', 'type' => 'javascript')
        file = "#{assets_dir}/#{js_file}"
        script.content = "\n#{File.read(file)}"
        script
      end

      def new_node(name, attributes = {})
        n = Nokogiri::XML::Node.new(name.to_s, self)
        attributes.each do | attr, value |
          n[attr.to_s] = value.to_s
        end
        n
      end
    end
  end
end

