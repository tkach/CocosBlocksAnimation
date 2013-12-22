Pod::Spec.new do |s|

  s.name         = "CocosBlocksAnimation"
  s.version      = "0.0.1"
  s.summary      = "Block-based animation helpers for Cocos2d."

  s.description  = "CocosBlocksAnimation is inspired by block-based UIView animation approach. 
  It allows you to create cocos2d animations easier — with the same approach as with UIView animations: 
  just describe the properties of your CCNode after animation duration and don't worry about any other things."

  s.homepage     = "https://github.com/tkach/CocosBlocksAnimation"
  s.license      = 'MIT '
  s.author       = { "Alexander Tkachenko" => "tkach2004@gmail.com" }

  s.platform     = :ios, '5.0'

  s.source       = { :git => "https://github.com/tkach/CocosBlocksAnimation.git", :tag => "0.0.1" }
  
  s.source_files  = 'CocosBlocksAnimation/CocosBlocksAnimation/**/*.{h,m,mm}'
  s.public_header_files = 'CocosBlocksAnimation/CocosBlocksAnimation/CocosBlocksAnimation.h'
  s.requires_arc = false
  
  s.dependency 'cocos2d', '~> 2.1'

end
