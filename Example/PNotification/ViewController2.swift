//
//  ViewController2.swift
//  NotificationExperiments
//
//  Created by Singh,Manish on 4/9/17.
//  Copyright © 2017 Singh,Manish. All rights reserved.
//

import UIKit
import PNotification

class ViewController2: UIViewController {
    
    @IBOutlet weak var payloadOutputLabel: UILabel!
    @IBOutlet weak var switchKillPersistant: UISwitch!

    @IBOutlet weak var observingStatusView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        observingStatusView.layer.cornerRadius = 10

        updateObservingStatus()
    }
    
    @IBAction func buttonClearClicked(_ sender: Any) {
        self.payloadOutputLabel.text = ""
    }

    @IBAction func buttonUnsafeRegisterClicked(_ sender: Any) {
        _ = PNotificationCenter.defaultCenter.addObserver(for:"experiment.notification", observer: self, selector:#selector(ViewController2.notificationReceived(notification:)))
        updateObservingStatus()
    }

    @IBAction func buttonUnregisterClicked(_ sender: Any) {
        PNotificationCenter.defaultCenter.removeObserver(observer: self)
        updateObservingStatus()
    }

    @IBAction func buttonRegisterClicked(_ sender: Any) {
        _ = PNotificationCenter.defaultCenter.addObserverGuardAgainstReObserving(notificationName:"experiment.notification", observer: self, selector:#selector(ViewController2.notificationReceived(notification:)))
        updateObservingStatus()
    }

    @objc func notificationReceived(notification:PNotification) {
        print("Received notification viewcontroller 1")
        if switchKillPersistant.isOn {
            notification.forget()
        }
        guard let payload = notification.payload as? String else {
            self.payloadOutputLabel.text = "Payload not received"
            return
        }
        if let existingText = self.payloadOutputLabel.text {
            self.payloadOutputLabel.text = existingText + ", " + payload
        }
        else {
            self.payloadOutputLabel.text = payload
        }
    }
    
    func updateObservingStatus() {
        if PNotificationCenter.defaultCenter.isAnObserver(object: self) {
            self.observingStatusView.backgroundColor = UIColor.green
        }
        else {
            self.observingStatusView.backgroundColor = UIColor.red
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
