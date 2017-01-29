Pod::Spec.new do |s|
  s.name             = "FullNavigationTransition"
  s.version          = "1.0.0"
  s.summary          = "A short description of FullNavigationTransition."
  s.homepage         = "https://github.com/francislata/FullNavigationTransition"
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { "Francis Lata" => "francisalbertlata@gmail.com" }
  s.source           = { git: "https://github.com/francislata/FullNavigationTransition.git", tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/francislata'
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.ios.source_files = 'FullNavigationTransition/Sources/**/*.{swift}'
  # s.resource_bundles = {
  #   'FullNavigationTransition' => ['FullNavigationTransition/Sources/**/*.xib']
  # }
  # s.ios.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'Eureka', '~> 1.0'
end
