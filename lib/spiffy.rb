require "github/markup"
require "haml"
require "pdfkit"

module Spiffy
  VERSION = "0.0.15"

  def self.markup_to_html(markup_file, css_file: nil, template_file: nil, output_html: true, output_pdf: false)
    markup_file_ext = File.extname(markup_file)
    markup_file_name = markup_file[0...-markup_file_ext.length]
    markup_file_directory = File.dirname(markup_file)
    markup = File.open(markup_file, "r:UTF-8", &:read)

    html = GitHub::Markup.render(markup_file, markup)
    
    if css_file
      css = File.open(css_file, "r:UTF-8", &:read)
    end

    if template_file
      template_ext = File.extname(template_file)
      template = File.open(template_file, "r:UTF-8", &:read)
      local_variables = {
        base_url: "file://#{File.absolute_path(markup_file_directory)}/",
        file: markup_file
      }
      html = case template_ext
             when ".erb"
               ERB.new(template).result do |section|
                 case section; when :css; css; when :body, nil; html; end
               end
             when ".haml"
               engine = Haml::Engine.new(template)
               engine.render(Object.new, local_variables) do |section|
                 case section; when :css; css; when :body, nil; html; end
               end
             else
               raise "Template file #{template_file} unsupported. Only .erb or .haml are supported."
             end
    end

    if output_html
      html_file = "#{markup_file_name}.html"
      File.open(html_file, "w:UTF-8") { |f| f.write(html) }
    end

    if output_pdf
      pdf_file = "#{markup_file_name}.pdf"
      pdf = PDFKit.new(html)
      pdf.stylesheets << css_file if css_file
      pdf.to_file(pdf_file)
    end
  end
end
