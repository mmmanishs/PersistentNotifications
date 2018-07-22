//
//  PNotificationObserver.swift
//  PNotificationCenter
//
//  Created by Singh,Manish on 9/20/16.
//  Copyright © 2016 Singh,Manish. All rights reserved.
//

import Foundation

public class PNotificationObserver: NSObject {
    var object: NSObject
    var selector: Selector
    var name: String
    
    init(name:String, observer:NSObject, selector:Selector){
        self.object = observer
        self.selector = selector
        self.name = name
        super.init()
    }
}
