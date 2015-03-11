require "optparse"
require "rubygems"
require "yaml"
require_relative "spiffy"
require_relative "spiffy_version"

module SpiffyCli
  DEFAULT_DIR = File.join(File.dirname(__FILE__), "../templates")
  DEFAULT_TEMPLATE_FILE = File.join(DEFAULT_DIR, "default.haml")
  DEFAULT_CSS_FILE = File.join(DEFAULT_DIR, "default.css")
  DEFAULT_HTML = true
  DEFAULT_PDF = false
  DOT_FILE = ".spiffy.yml"

  def self.main
    options = {}

    opt_parser = OptionParser.new do |opt|
      opt.banner = "Usage: spiffy [options] [file] [file] ..."
      opt.separator("Version: #{SpiffyVersion::VERSION}")
      opt.separator("")
      opt.separator("Options")

      opt.on("-c", "--css [css]", "CSS to include inline in the HTML file output") do |css|
        options[:css_file] = css
      end

      opt.on("-t", "--template [template]", "Template to wrap the resulting HTML") do |template|
        options[:template_file] = template
      end

      opt.on("-p", "--pdf [on|off]", "Output PDF files (default: off)") do |on_or_off|
        options[:pdf] = on_or_off != "off"
      end

      opt.on("-m", "--html [on|off]", "Output HTML files (default: on)") do |on_or_off|
        options[:html] = on_or_off != "off"
      end

      opt.on("-h", "--help", "This usage outline.") do
        puts opt_parser
        options[:help] = true
      end

      opt.separator("")
      
      opt.separator("Alternatively:")
      opt.separator("Create a .spiffy.yml in this directory with options within.")
      opt.separator("See https://github.com/leighmcculloch/spiffy.")
      
      opt.separator("")
    end

    opt_parser.parse!

    return if options[:help]
    
    self.handle(options)
  end

  def self.handle(options)
    has_dot_file = File.exists?(DOT_FILE)

    if File.exists?(DOT_FILE)
      sets = YAML.load_file(DOT_FILE)
    end

    if ARGV.any?
      sets = ARGV.map do |arg|
        set = sets.find({}) do |set|
          set["markdown_files"].any? do |markdown_file|
            File.fnmatch(markdown_file, arg)
          end
        end
        set.merge({ "markdown_files" => [arg] })
      end
    end

    if !sets
      puts opt_parser
      return
    end

    sets.each do |set|
      set["markdown_files"].each do |input|
        Dir[input].each do |file|
          print "Converting #{file}..."

          output_html = options[:html]
          output_html = set["html"] if output_html.nil?
          output_html = DEFAULT_HTML if output_html.nil?

          output_pdf = options[:pdf]
          output_pdf = set["pdf"] if output_pdf.nil?
          output_pdf = DEFAULT_PDF if output_pdf.nil?

          Spiffy.markup_to_html(file,
                                css_file: options[:css_file] || set["css_file"] || DEFAULT_CSS_FILE,
                                template_file: options[:template_file] || set["template_file"] || DEFAULT_TEMPLATE_FILE,
                                output_html: output_html,
                                output_pdf: output_pdf)
          puts "done"
        end
      end
    end
  end
end
