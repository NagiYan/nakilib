

Pod::Spec.new do |s|
  s.name         = "nakilib"
  s.version      = "1.0.8"
  s.source       = { :git => "https://github.com/NagiYan/nakilib.git", :tag => "1.0.8" }
  s.summary      = "my lib, with some usefull tools"
  s.description  = <<-DESC
			my lib, with some usefull tools, for private use
                   DESC
  s.homepage     = "https://github.com/NagiYan/nakilib"
  s.license      = "MIT"
  s.author       = { "nagi" => "yxj@foxmail.com" }
  s.platform     = :ios, "7.0"
  
  s.default_subspec = 'All'
  s.subspec 'All' do |spec|
    spec.ios.dependency 'nakilib/MRC'
    spec.ios.dependency 'nakilib/ARC'
  end
  
  s.subspec 'MRC' do |spec|
    spec.requires_arc = false
    spec.source_files = "nakilib/ui/view/MKNumberBadgeView.*"
    spec.exclude_files = "nakilib/LICENSE"
    spec.frameworks = "UIKit"
  end

  s.subspec 'ARC' do |spec|
    spec.requires_arc = true
    spec.source_files = "nakilib/**/*", "nakilib/ui/**/*", "nakilib/communication/**/*", "nakilib/device/**/*"
    spec.exclude_files = "nakilib/LICENSE", "nakilib/ui/view/MKNumberBadgeView.*"
    spec.frameworks = "UIKit"

    s.dependency 'SAMWebView'
    s.dependency 'ReactiveCocoa', '~> 2.5' 
    s.dependency 'AFNetworking'
    s.dependency 'Masonry' 
    s.dependency 'Reachability' 
    s.dependency 'MJRefresh' 
    s.dependency 'MGSwipeTableCell'
    s.dependency 'ChameleonFramework' 
    s.dependency 'pop'
    s.dependency 'SDWebImage' 
  end
end
