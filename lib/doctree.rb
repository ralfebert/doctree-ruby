require 'doctree/version'
require 'tree'
require 'json'
require 'nokogiri'

module DocTree

  class DocTreeNode < Tree::TreeNode
  
    attr_accessor :attrs
    attr_accessor :name
  
    def attrs
      @attrs ||= { }
    end
    
    def href
      attrs[:href]
    end

    def href=(new_value)
      attrs[:href] = new_value
    end
    
    def to_s
      self.string_value { |node| node.name + if node.attrs and !node.attrs.empty? then " -- " + node.attrs.to_json.gsub("\n", "") else "" end }
    end
  
    def string_value(depth = 0, indent = "\t", &block)
      childStr = self.children.count > 0 ? "\n" + children.map{ |node| node.string_value(depth + 1, &block) }.join("\n") : ""
      return [indent * depth, block.call(self), childStr].join("")
    end
  
    def self.forHTML(html)
      return DocTreeNode.new(html.title, html) if html.is_a? Nokogiri::XML::Document

      if html.name == 'a'
        node = DocTreeNode.new(html.text.strip, html)
        node.href = html["href"].to_s
        return node
      end

      raise "Unsupported node \"#{node.name}\", expected a Nokigiri XML/HTML document or <a> element"
    end
    
    def map_html_tree(html, &block)
      parent = if result = block.call(html) then self << result else self end
      html.children.each { |c| parent.map_html_tree(c, &block) }
    end
  
  end

end