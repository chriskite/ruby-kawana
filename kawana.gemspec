spec = Gem::Specification.new do |s|
  s.name = "kawana"
  s.version = "0.0.0"
  s.author = "Chris Kite"
  s.homepage = "http://www.github.com/chriskite/ruby-kawana"
  s.platform = Gem::Platform::RUBY
  s.summary = "Kawana client"
  s.require_path = "lib"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.md"]

  s.files = %w[
    LICENSE
    README.md
  ] + Dir['lib/**/*.rb']
end
