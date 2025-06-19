Pod::Spec.new do |s|
  s.name             = 'StravaKit'
  s.version          = '1.0.1'
  s.summary          = 'A modern Swift library for the Strava API v3'
  s.description      = <<-DESC
A Swift library for the Strava API v3, built with modern Swift practices such as async/await and Codable. Fully native with no external dependencies.
                       DESC
  s.homepage         = 'https://github.com/ferrufino/StravaKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Gustavo Ferrufino' => 'guferruf@gmail.com' }
  s.source           = { :git => 'https://github.com/ferrufino/StravaKit.git', :tag => s.version.to_s }
  s.swift_version    = '5.9'
  s.ios.deployment_target = '14.0'
  s.source_files = 'Sources/StravaKit/**/*'
end
