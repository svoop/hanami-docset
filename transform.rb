#!/usr/bin/env ruby

version = ARGV.first
version_re = Regexp.escape(version)

{
  '**/*.html' => {
    %r{<header[> ].*?</header>}m => "<header>Hanami #{version}</header>",
    %r{<nav[> ].*?</nav>}m => '',
    %r{<ul class="section-nav"[> ].*?</ul>}m => '',
    %r{>v#{version_re}:\s*}i => '>',
    %r{"/v#{version_re}/(.*)"} => '"/../../\1/index.html"'
  }
}.each do |glob, transformations|
  transformations.each do |pattern, replace|
    Dir[glob].each do |file|
      File.read(file).then do |html|
        File.write(file, html.gsub(pattern, replace))
      end
    end
  end
end
