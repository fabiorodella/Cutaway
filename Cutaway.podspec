Pod::Spec.new do |s|
  s.name             = "Cutaway"
  s.version          = "0.1.0"
  s.summary          = "Create segues between different storyboards."
  s.description      = <<-DESC
                       **Cutaway** provides an easy way to link scenes in different storyboards through regular segues (no custom segues needed).
                       DESC
  s.homepage         = "https://github.com/fabiorodella/Cutaway"
  s.license          = 'MIT'
  s.author           = { "Fabio Rodella" => "fabiorodella@gmail.com" }
  s.source           = { :git => "https://github.com/fabiorodella/Cutaway.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Cutaway' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
end
