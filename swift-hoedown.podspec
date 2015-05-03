Pod::Spec.new do |s|
  s.name         = "swift-hoedown"
  s.version      = "0.1"
  s.summary      = "Swift bindings for Hoedown."
  s.homepage     = "http://EXAMPLE/swift-hoedown"
  s.license      = "MIT"
  s.author             = { "Niels de Hoog" => "njdehoog@gmail.com" }
  s.social_media_url   = "http://twitter.com/nielsify"
  s.source       = { :git => "https://github.com/njdehoog/swift-hoedown.git", :tag => s.version }
  s.source_files  = "src"
  s.dependency "hoedown", "~> 3.0"
end
