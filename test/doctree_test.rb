require 'test_helper'
require 'pry'
require 'nokogiri'

class DoctreeTest < Minitest::Test
  
  def test_that_it_has_a_version_number
    refute_nil ::DocTree::VERSION
  end

  def test_create_document
    doctree_path = File.join(File.dirname(__FILE__), 'example.doctree')

    root = DocTree::DocTreeNode.new("Root")
    foo = root << DocTree::DocTreeNode.new("1. Foo")
    bar = root << DocTree::DocTreeNode.new("2. Bar")
    bar1 = bar << DocTree::DocTreeNode.new("2.1. Gin Fizz")
    bar2 = bar << DocTree::DocTreeNode.new("2.2. Pina Colada")
    bar2.href = "https://en.wikipedia.org/wiki/Pina_colada"
    assert_equal File.read(doctree_path), root.to_s
  end

  def test_parse_wikipedia_toc
    html_path = File.join(File.dirname(__FILE__), 'wikipedia-toc.html')
    doctree_path = File.join(File.dirname(__FILE__), 'wikipedia-toc.doctree')

    tree = DocTree::DocTreeNode.forHTML(Nokogiri::HTML(File.read(html_path)))

    tree.map_html_tree(tree.content.css("#toc").first) do |html|
      if html.name == 'li' and link = html.css(">a").first
        DocTree::DocTreeNode.forHTML(link)
      end
    end

    assert_equal File.read(doctree_path), tree.to_s
  end
  
  def test_html2doctree
    html2doctree_path = File.join(File.dirname(__FILE__), '../exe/html2doctree')
    html_path = File.join(File.dirname(__FILE__), 'wikipedia-toc.html')
    doctree_path = File.join(File.dirname(__FILE__), 'wikipedia-toc.doctree')
    
    assert_equal File.read(doctree_path), `cat #{html_path} | ruby #{html2doctree_path} --css "#toc"`.strip
  end
  
  
end
