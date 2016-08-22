require "fileutils"
require "github/markup"
require "haml"
require "pdfkit"
require "yaml"

module Spiffy
  def self.markup_to_html(markup_file, css_file: nil, template_file: nil, output_html: true, output_pdf: false, output_dir: nil)
    markup_file_ext = File.extname(markup_file)
    markup_file_name = File.basename(markup_file, ".*")
    markup_file_directory = File.dirname(markup_file)
    contents = File.open(markup_file, "r:UTF-8", &:read)

    markup_pieces = contents.split("\n---\n")
    metadata, html = if markup_pieces.length == 2
      [ YAML.load(markup_pieces.first), GitHub::Markup.render(markup_file, markup_pieces.last) ]
    elsif markup_pieces.length == 1
      [ {}, GitHub::Markup.render(markup_file, contents) ]
    else
      raise "Found too many documents separated by --- in file #{markup_file}"
    end

    if css_file
      css = File.open(css_file, "r:UTF-8", &:read)
    end

    if template_file
      template_ext = File.extname(template_file)
      template = File.open(template_file, "r:UTF-8", &:read)
      local_variables = {
        base_url: "file://#{File.absolute_path(markup_file_directory)}/",
        file: markup_file,
        meta: metadata,
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

    output_dir = File.join(output_dir, "") if output_dir
    output_dir = "#{output_dir}#{markup_file_directory}"
    FileUtils.mkdir_p(output_dir) unless File.directory?(output_dir)

    if output_html
      html_file = File.join(output_dir, "#{markup_file_name}.html")
      File.open(html_file, "w:UTF-8") { |f| f.write(html) }
    end

    if output_pdf
      pdf_file = File.join(output_dir, "#{markup_file_name}.pdf")
      pdf = PDFKit.new(html)
      pdf.stylesheets << css_file if css_file
      pdf.to_file(pdf_file)
    end
  end
end
