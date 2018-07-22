//
//  PNotification.swift
//  PNotificationCenter
//
//  Created by Singh,Manish on 9/20/16.
//  Copyright © 2016 Singh,Manish. All rights reserved.
//

import Foundation
public class PNotification: NSObject {
    public var name: String
    public var payload: AnyObject?
    public var notificationFireType: NotificationFireType
    var numberOfTimesDispatched: Int = 0
    
    init(name :String, payload :AnyObject?, notificationFireType :NotificationFireType){
        self.name = name
        self.payload = payload
        self.notificationFireType = notificationFireType
        super.init()
    }
    
    public func forget() {
        PNotificationCenter.defaultCenter.removeFromQueue(notification: self)
    }
    
    func wasDispatched()  {
        numberOfTimesDispatched = numberOfTimesDispatched + 1
    }
    
    func shouldRemoveFromQueue() -> Bool {
        switch notificationFireType {
        case .notificationFireAndForget:
            return true
        case .notificationFireAndRememberOnceIfNotIntercepted:
            return self.numberOfTimesDispatched >= 1
        case .notificationFireAndPersist:
            return false
        }
    }
    
    static func == (lhs: PNotification, rhs: PNotification) -> Bool {
        return lhs.name == rhs.name
    }
}
