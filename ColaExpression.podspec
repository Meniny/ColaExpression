Pod::Spec.new do |s|
  s.name             = "ColaExpression"
  s.version          = "1.2.0"
  s.summary          = "A Cross-Platform Regular Expression Library written in Swift."
  s.description      = <<-DESC
                        ColaExpression is a Cross-Platform Regular Expression Library written in Swift.
                        DESC

  s.homepage         = "https://github.com/Meniny/ColaExpression"
  s.license          = 'MIT'
  s.author           = { "Meniny" => "Meniny@qq.com" }
  s.source           = { :git => "https://github.com/Meniny/ColaExpression.git", :tag => s.version.to_s }
  s.social_media_url = 'http://meniny.cn/'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '3.0'

  s.source_files = 'ColaExpression/**/*.*'
  s.public_header_files = 'ColaExpression/*{.h}'
  s.frameworks = 'Foundation'
end
