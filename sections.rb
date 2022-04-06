require 'yaml'

module Gollum
  class Macro
    class Sections < Gollum::Macro
      def render(query)
        return if @wiki.pages.size == 0

        strings = @wiki.pages.map do |page|

          # search the markup
          lines = page.text_data.each_line
          hasMeta = false
          strMeta = ""
          lines.each_with_index do |line, i|
            break if i == 0 && line != "---\n" # first line
            break if i > 10 # limit exit
            if i > 0 && (line == "---\n" || line == "---") # last line
              hasMeta = true
              break
            end
            strMeta << line
          end
          next if !hasMeta
          # puts meta
          begin
            frontmatter = ::YAML.safe_load(strMeta)
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
