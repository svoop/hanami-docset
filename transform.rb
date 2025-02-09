#!/usr/bin/env ruby

version = ARGV.first
version_re = Regexp.escape(version)

# Create main page
main_html = File.read('introduction/getting-started/index.html')
  .sub(%r{<header[> ].*?</header>}m, "<header>Hanami #{version}</header><h1>🌸 Hanami</h1><hr><br>")
  .sub(%r{<main[> ].*?</body>}m, '</body>')
  .gsub(%r{(<a href=")https://guides.hanamirb.org/v2.2/(.*?)"}, '\1\2index.html"')

# Guides and sections
{
  '**/*.html' => {
    %r{<header[> ].*?</header>}m => ->(*) { "<header>Hanami #{version}</header>" },
    %r{<nav[> ].*?</nav>}m => ->(*) { '' },
    %r{<ul class="section-nav"[> ].*?</ul>}m => ->(*) { '' },
    %r{>v#{version_re}:\s*}i => ->(*) { '>' },
    %r{"/v#{version_re}/(.*)"} => ->(*) { %("/../../#{$1}/index.html") },
    %r{<h1.*?>(.*?)</h1>} => ->(*) { "<h1>#{@prefix} – #{$1}</h1>" }
  }
}.each do |glob, transformations|
  Dir[glob].each do |file|
    @prefix = file.split('/').first.gsub('-', ' ')
      .capitalize
      .sub(/(cli|api)/i) { it.upcase }
    File.read(file).then do |html|
      transformations.each do |pattern, replace|
        html = html.gsub(pattern, &replace)
      end
      File.write(file, html)
    end
  end
end

# Write main page
File.write('index.html', main_html)
