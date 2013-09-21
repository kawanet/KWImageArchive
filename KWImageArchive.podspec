Pod::Spec.new do |s|
  s.name         = "KWImageArchive"
  s.version      = "0.0.4"
  s.summary      = "KWImageArchive loads image files stored in a ZIP file."
  s.homepage     = "https://github.com/kawanet/KWImageArchive"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { "Yusuke Kawasaki" => "u-suke@kawa.net" }
  s.source       = { :git => "https://github.com/kawanet/KWImageArchive.git", :tag => "0.0.4" }
  s.platform     = :ios, '6.0'
  s.source_files = 'src'
  s.requires_arc = true
  s.dependency 'zipzap'
end
