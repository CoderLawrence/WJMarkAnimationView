#
# Be sure to run `pod lib lint WJMarkAnimationView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WJMarkAnimationView'
  s.version          = '0.1.0'
  s.summary          = '一个简单易用好看的打勾动画UI控件'
  s.description      = <<-DESC
                        一个简单易用好看的打勾动画UI控件
                       DESC

  s.homepage         = 'https://github.com/CoderLawrence/WJMarkAnimationView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CoderLawrence' => '791785648@qq.com' }
  s.source           = { :git => 'https://github.com/CoderLawrence/WJMarkAnimationView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'WJMarkAnimationView/Classes/**/*'

  s.public_header_files = 'WJMarkAnimationView/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  
end
