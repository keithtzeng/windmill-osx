//
//  ProjectTitlebarAccessoryViewController.swift
//  windmill
//
//  Created by Markos Charatzas on 10/3/18.
//  Copyright © 2018 qnoid.com. All rights reserved.
//

import AppKit
import os

class ProjectTitlebarAccessoryViewController: NSTitlebarAccessoryViewController {
    
    @IBOutlet weak var launchMenuItem: NSMenuItem!
    @IBOutlet weak var launchButton: NSButton! {
        didSet{
            self.isLaunchButtonEnabledObserver = launchButton.observe(\.isEnabled, options: [.initial, .new]) { [weak self] (button, change) in
                if let isEnabled = change.newValue {
                    if isEnabled {
                        button.toolTip = NSLocalizedString("windmill.launchsimulator.button.enabled.toolTip", comment: "")
                        self?.launchMenuItem.toolTip = NSLocalizedString("windmill.launchsimulator.button.enabled.toolTip", comment: "")
                    } else {
                        button.toolTip = NSLocalizedString("windmill.launchsimulator.button.disabled.toolTip", comment: "")
                        self?.launchMenuItem.toolTip = NSLocalizedString("windmill.launchsimulator.button.disabled.toolTip", comment: "")
                    }
                }
            }
            self.launchButton.isEnabled = false
        }
    }
    
    let log = OSLog(subsystem: "io.windmill.windmill", category: "windmill")
    
    var isLaunchButtonEnabledObserver: NSKeyValueObservation?
    
    var appBundle: AppBundle?
    
    var destination: Devices.Destination?
    
    deinit {
        isLaunchButtonEnabledObserver?.invalidate()
    }
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func didSet(windmill: Windmill, notificationCenter: NotificationCenter = NotificationCenter.default) {
        notificationCenter.addObserver(self, selector: #selector(willStartProject(_:)), name: Windmill.Notifications.willStartProject, object: windmill)
        notificationCenter.addObserver(self, selector: #selector(activityDidExitSuccesfully(_:)), name: Windmill.Notifications.activityDidExitSuccesfully, object: windmill)
        notificationCenter.addObserver(self, selector: #selector(didBuildProject(_:)), name: Windmill.Notifications.didBuildProject, object: windmill)
    }
    
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        if item.action == #selector(launchOnSimulator(_:)) {
            return self.launchButton.isEnabled
        }
        
        return true
    }
    
    override func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        if menuItem.action == #selector(launchOnSimulator(_:)) {
            return self.launchButton.isEnabled
        }
        
        return true
    }
    
    @objc func willStartProject(_ aNotification: Notification) {
        self.launchButton.isEnabled = false
    }

    @objc func activityDidExitSuccesfully(_ aNotification: Notification) {
        guard let activity = aNotification.userInfo?["activity"] as? ActivityType else {
            return
        }
        
        switch activity {
        case .test:
            self.launchButton.isEnabled = true
        default:
            return
        }
    }
    
    @objc func didBuildProject(_ aNotification: NSNotification) {
        
        guard let appBundle = aNotification.userInfo?["appBundle"] as? AppBundle, let destination = aNotification.userInfo?["destination"] as? Devices.Destination else {
            return
        }
                
        self.appBundle = appBundle
        self.destination = destination
        Process.makeInstall(destination: destination, appBundle: appBundle).launch()
    }

    @IBAction func launchOnSimulator(_ sender: Any) {
        
        guard let appBundle = appBundle, let destination = destination else {
            os_log("AppBundle and/or Destination are not available.", log: log, type: .debug)
            return
        }
        
        let process = Process.makeLaunch(destination: destination, info: appBundle.info)
        process.launch()
    }
}