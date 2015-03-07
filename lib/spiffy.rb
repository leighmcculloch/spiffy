require "github/markup"
require "redcarpet"
require "RedCloth"
require "rdoc"
require "org-ruby"
require "creole"
require "wikicloth"
require "asciidoctor"
require "haml"

module Spiffy
  def self.markup_to_html(markup_file, css_file: nil, template_file: nil)
    markup_file_name = File.basename(markup_file, ".*")
    markup = File.open(markup_file, "r:UTF-8", &:read)

    html = Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true).render(markup)
    
    if css_file
      css = File.open(css_file, "r:UTF-8", &:read)
    end

    if template_file
      template_ext = File.extname(template_file)
      template = File.open(template_file, "r:UTF-8", &:read)
      html = case template_ext
             when ".erb"
               ERB.new(template).result { |section| case section; when :css; css; when :body; html; end }
             when ".haml"
               Haml::Engine.new(template).render { |section| case section; when :css; css; when :body; html; end }
             else
               raise "Template file #{template_file} unsupported. Only .erb or .haml are supported."
             end
    end

    out_file = "#{markup_file_name}.html"
    File.open(out_file, "w:UTF-8") { |f| f.write(html) }
  end
end
