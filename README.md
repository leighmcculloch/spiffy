# spiffy
A simple to use markdown to HTML and PDF terminal application.

Supports Github flavored markdown and great for converting large numbers of documents into professional PDFs using ERB/HAML templates and CSS.

## Install

```bash
$ gem install spiffy
```

Or in your Gemfile:
```bash
gem 'spiffy'
```

## Use

```bash
$ spiffy
Usage: spiffy [options] [file] [file] ...

Options
    -c, --css [css]                  CSS to include inline in the HTML file output
    -t, --template [template]        Template to wrap the resulting HTML
    -p, --pdf [on|off]               Output PDF files (default: off)
        --html [on|off]              Output HTML files (default: on)
    -h, --help                       This usage outline.
```

You can also specify options in a `.spiffy.yml` file. Running `spiffy` in a directory containing a spiffy YAML file will cause spiffy to run on all the files matched/specified by the YAML.

Example:

```yaml
# Markdown files starting with the word `Legal` use the legal template.
- markdown_files:
    - Legal *.md
  template_file: Legal.haml
  html: false
  pdf: true

# Markdown file Resume.md will use custom CSS.
- markdown_files:
    - Resume.md
  template_file: Resume.css
  pdf: true
```
