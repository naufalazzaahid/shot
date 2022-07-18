Pod::Spec.new do |s|
  s.name             = 'Shot'
  s.version          = '1.0.0'
  s.summary          = 'Compile time dependency injection.'

  s.description      = <<-DESC
Compile time dependency injection.
                       DESC

  s.homepage         = 'https://github.com/naufalazzaahid/Shot'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'naufalazzaahid' => 'naufal.azzaahid@quipper.com' }
  s.source           = { :git => 'https://github.com/naufalazzaahid/Shot.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'

  s.source_files = 'Source/Module/**/*.{swift}','templates/**/*.{stencil}'
  s.resource_bundles = {
    'Shot' => ['Source/Module/**/*.xcassets']
  }

  s.static_framework = true

  s.dependency 'Sourcery'

  s.test_spec 'Tests' do |test_spec|
      test_spec.source_files = 'Source/Tests/**/*.{swift}'
  end
end
