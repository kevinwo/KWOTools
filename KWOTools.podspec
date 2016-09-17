Pod::Spec.new do |s|
  s.name         = "KWOTools"
  s.version      = "0.1"
  s.summary      = "Fun tools for making fun apps"
  s.homepage     = "https://github.com/kevinwo/KWOTools"
  s.author       = { "Kevin Wolkober" => "kevin.wolkober@gmail.com" }
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.source       = { :git => "git@github.com:kevinwo/KWOTools.git", :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files = 'KWOTools/**/*.{h,m,swift}'
  s.frameworks = 'Foundation'
end
