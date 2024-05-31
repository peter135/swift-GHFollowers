//
//  Constants.swift
//  GHFollowers
//
//  Created by apple on 2024/5/29.
//

import UIKit

enum SFSymbols {
    static let location = "mappin.and.ellipse"
    static let repos = "folder"
    static let gists = "text.alignleft"
    static let followers = "heart"
    static let following = "person.2"

}

enum Images {
    static let ghLogo = UIImage(named: "gh-logo")
    static let placeholder = UIImage(named: "avatar-placeholder")
    static let emptyStateLogo = UIImage(named: "empty-state-logo")

}

enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let hegith       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.hegith)
    static let minLength    = min(ScreenSize.width, ScreenSize.hegith)

}

enum DeviceTypes {
    
    static let idiom       = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale       = UIScreen.main.scale
    
    static let isIphoneSE            = idiom == .phone && ScreenSize.maxLength == 568
    static let isIphone8Standard     = idiom == .phone && ScreenSize.maxLength == 667 && nativeScale==scale
    static let isIphone8Zoomed       = idiom == .phone && ScreenSize.maxLength == 667 && nativeScale>scale
    static let isIphone8PlusStandard = idiom == .phone && ScreenSize.maxLength == 736
    static let isIphoneX             = idiom == .phone && ScreenSize.maxLength == 821
    static let isIphoneXsMaxAndXr    = idiom == .phone && ScreenSize.maxLength == 896

    static func isiphoneXAspectRatio() -> Bool {
        return isIphoneX || isIphoneXsMaxAndXr
    }
    
}

