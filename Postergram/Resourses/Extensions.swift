//
//  Extensions.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 01.12.2022.
//

import UIKit

extension UIView {
    
    public var widthExt: CGFloat {
        return frame.size.width
    }
    
    public var heightExt: CGFloat {
        return frame.size.height
    }
    
    public var topExt: CGFloat {
        return frame.origin.y
    }
    
    public var bottomExt: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var leftExt: CGFloat {
        return frame.origin.x
    }
    
    public var rightExt: CGFloat {
        return frame.origin.x + frame.size.width
    }
    
}
