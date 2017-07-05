//
//  AppExtension.swift
//  datepicker textfield
//
//  Created by apple on 05/07/17.
//  Copyright © 2017 Apoorv Mote. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    func setCardView(view : UIView){
        
        view.layer.cornerRadius = 5.0
        view.layer.borderColor  =  UIColor.clear.cgColor
        view.layer.borderWidth = 5.0
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor =  UIColor.lightGray.cgColor
        view.layer.shadowRadius = 5.0
        view.layer.shadowOffset = CGSize(width:5, height: 5)
        view.layer.masksToBounds = false
        
    }
    func setViewAnimted(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .showHideTransitionViews, animations: { _ in
            view.isHidden = hidden
        }, completion: nil)
    }
    
}

extension UITextField{
    func makeRoundedEdge(boarderWidth:CGFloat?, borderColour: UIColor?,cornerRadius:CGFloat?)
    {
        layer.cornerRadius = cornerRadius!
        layer.borderWidth = boarderWidth!
        layer.borderColor = borderColour?.cgColor
    }
}
