//
//  Extensions.swift
//  StyleGuide
//
//  Created by Shubham Agrawal on 27/10/17.
//

import Foundation

extension UIView {
    @IBInspectable var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var viewBorderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return    UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            if let color = newValue?.cgColor {
                layer.borderColor = color
            }
        }
    }
}
