# spiffy
A simple to use markdown to HTML and PDF command line app.

Supports Github flavored markdown and great for converting single or many documents into professional PDFs using ERB/HAML templates and CSS.

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
    -m, --html [on|off]              Output HTML files (default: on)
    -o, --out [output directory]     Output files to this directory
    -h, --help                       This usage outline.
```

You can also specify options in a `.spiffy.yml` file. Running `spiffy` in a directory containing a spiffy YAML file will cause spiffy to run on all the files matched/specified by the YAML.

Example:

```yaml
# Markdown files starting with the word `Legal` use the legal
# template, and put the PDFs in the Output folder.
- markdown_files:
    - Legal *.md
  template_file: Legal.haml
  html: false
  pdf: true
  output_dir: Output

# Markdown file Resume.md will use custom CSS, and put the PDF
# and HTML next to the input file.
- markdown_files:
    - Resume.md
  template_file: Resume.css
  pdf: true
```
