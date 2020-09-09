require 'yaml'

module Gollum
  class Macro
    class Sections < Gollum::Macro
      def render(query)
        return if @wiki.pages.size == 0

        strings = @wiki.pages.map do |page|

          # search the markup
          lines = page.text_data.each_line
          # start line
          str = lines.next
          next if str != "---\n"
          meta = ""
          # end line with limit
          for i in 1..15 do
            str = lines.next
            break if str == "---\n"
            meta << str
          end
          # have meta?
          next if str != "---\n"
          # puts meta
          begin
            frontmatter = ::YAML.safe_load(meta)
            # puts frontmatter
          rescue 
            next
          end

          s = frontmatter['sections']
          t = frontmatter['title']
          t = page.title if !t

          if s && s.include?(query) 
            "<li><a href=\"#{page.escaped_url_path}\">#{t} (#{page.url_path})</a></li>"
          end

        end
        
        return "<ul>" + strings.compact.join + "</ul>"

      end
    end
  end
end