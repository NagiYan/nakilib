

Pod::Spec.new do |s|
  s.name         = "nakilib"
  s.version      = "1.0.7"
  s.summary      = "my lib, with some usefull tools"
  s.description  = <<-DESC
			my lib, with some usefull tools, for private use
                   DESC

  s.homepage     = "https://github.com/NagiYan/nakilib"
  s.license      = "MIT"
  s.author       = { "nagi" => "yxj@foxmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/NagiYan/nakilib.git", :tag => "1.0.7" }
  s.default_subspec = 'All'
  s.subspec 'All' do |spec|
    spec.ios.dependency 'nakilib/MRC'
    spec.ios.dependency 'nakilib/ARC'
  end
  
  s.subspec 'MRC' do |spec|
    spec.requires_arc = false
    spec.source_files  = "nakilib/**/*", "nakilib/ui/**/*", "nakilib/communication/**/*", "nakilib/device/**/*"
    spec.exclude_files = "nakilib/LICENSE", "nakilib/ui/View/SquareLoadingView.*", "nakilib/ui/View/SimpleWebView.*"
    spec.frameworks = "UIKit", "ImageIO", "MapKit"

    s.dependency 'AFNetworking'
    s.dependency 'Masonry' 
    s.dependency 'Reachability' 
    s.dependency 'MJRefresh' 
    s.dependency 'MGSwipeTableCell'
    s.dependency 'ReactiveCocoa', '~> 2.5' 
    s.dependency 'ChameleonFramework' 
    s.dependency 'pop'
    s.dependency 'SDWebImage' 
  end

  s.subspec 'ARC' do |spec|
    spec.requires_arc = true
    spec.source_files = "nakilib/LICENSE", "nakilib/ui/View/SquareLoadingView.*", "nakilib/ui/View/SimpleWebView.*"
    spec.frameworks = "UIKit"

    s.dependency 'SAMWebView'
    s.dependency 'Masonry' 
    s.dependency 'ReactiveCocoa', '~> 2.5' 
    s.dependency 'pop'
  end
end
