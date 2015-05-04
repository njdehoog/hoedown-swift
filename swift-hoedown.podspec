Pod::Spec.new do |s|
  s.name         = "swift-hoedown"
  s.version      = "0.1"
  s.summary      = "Swift bindings for Hoedown."
  s.homepage     = "https://github.com/njdehoog/swift-hoedown"
  s.license      = "MIT"
  s.author             = { "Niels de Hoog" => "njdehoog@gmail.com" }
  s.social_media_url   = "http://twitter.com/nielsify"
  s.source       = { :git => "https://github.com/njdehoog/swift-hoedown.git", :tag => s.version }
  s.source_files  = "src/*.swift"
  s.dependency "hoedown", "~> 3.0"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.module_name = "Swift-Hoedown"
end
