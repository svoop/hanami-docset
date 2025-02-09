#!/usr/bin/env ruby

version = ARGV.first
version_re = Regexp.escape(version)

{
  '**/*.html' => {
    %r{<header[> ].*?</header>}m => ->(*) { "<header>Hanami #{version}</header>" },
    %r{<nav[> ].*?</nav>}m => ->(*) { '' },
    %r{<ul class="section-nav"[> ].*?</ul>}m => ->(*) { '' },
    %r{>v#{version_re}:\s*}i => ->(*) { '>' },
    %r{"/v#{version_re}/(.*)"} => ->(*) { '"/../../\1/index.html"' },
    %r{<h1.*?>Overview</h1>} => ->(prefix) { "<h1>#{prefix} overview</h1>" }
  }
}.each do |glob, transformations|
  Dir[glob].each do |file|
    overview_prefix = file.split('/').first.gsub('-', ' ').capitalize
    File.read(file).then do |html|
      transformations.each do |pattern, replace_proc|
        html = html.gsub(pattern, replace_proc.call(overview_prefix))
      end
      File.write(file, html)
    end
  end
end
