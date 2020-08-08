#source 'https://github.com/CocoaPods/Specs.git'
source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
platform :ios, '11.0'

workspace 'GreatPeotry'

use_frameworks!
#关闭CocoaPods中的警告
inhibit_all_warnings!


def pods_common
  pod 'RxSwift'
  pod 'SnapKit'
  pod 'RxCocoa'
  pod 'HandyJSON'
  pod 'Kingfisher'
  pod 'KRProgressHUD'
  pod 'R.swift'
  pod 'RealmSwift'
  pod 'VerticalCardSwiper'
  pod 'SkeletonView'
  pod 'SwiftEntryKit'
  pod 'Nuke'
  pod 'CryptoSwift'
  pod 'Alamofire'
  pod 'RxAlamofire'
  pod 'ReachabilitySwift'
  pod 'MJRefresh'
end

def pods_home
end

def pods_mine
  
end

def pods_creation
  
end

def pods_foudation
  
end


target 'GreatPeotry' do

  project './GreatPeotry.xcodeproj'
  pods_common
  pods_home
  pods_creation
  pods_mine
  
end


target 'Mine' do
  
  project './Mine/Mine.xcodeproj'
  pods_common
  pods_mine

end

target 'Home' do

  project './Home/Home.xcodeproj'
  pods_common
  pods_home

end


target 'Creation' do

  project './Creation/Creation.xcodeproj'
  pods_common
  pods_creation

end

target 'Router' do

  project './Router/Router.xcodeproj'
  pods_common

end


target 'GPFoundation' do

  project './GPFoundation/GPFoundation.xcodeproj'
  pods_common
  pods_foudation

end

