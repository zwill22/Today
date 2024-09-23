//
//  CAGradientLayerListStyle.swift
//  Today
//
//  Created by Zack Williams on 23/09/2024.
//

import UIKit

extension CAGradientLayer {
    static func gradientLayer(for style: ReminderListStyle, in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colours(for: style)
        layer.frame = frame
        
        return layer
    }
    
    private static func colours(for style: ReminderListStyle) -> [CGColor] {
        let beginColour: UIColor
        let endColour: UIColor
        
        switch style {
        case .all:
            beginColour = .todayGradientAllBegin
            endColour = .todayGradientAllEnd
        case .future:
            beginColour = .todayGradientFutureBegin
            endColour = .todayGradientFutureEnd
        case .today:
            beginColour = .todayGradientTodayBegin
            endColour = .todayGradientTodayEnd
        }
        
        return [beginColour.cgColor, endColour.cgColor]
    }
}
