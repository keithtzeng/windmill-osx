//
//  ProjectsViewController.swift
//  windmill
//
//  Created by Markos Charatzas on 10/01/2016.
//  Copyright © 2016 qnoid.com. All rights reserved.
//

import AppKit

public class ProjectsViewController: NSViewController, WindmillDelegate
{
    static let logger : ConsoleLog = ConsoleLog()
    
    @IBOutlet public weak var outlineView: NSOutlineView!
    @IBOutlet weak var buildProgressIndicator: NSProgressIndicator!
    @IBOutlet public weak var buildTextField: NSTextField!
    
    var windmill: Windmill! {
        didSet{
            self.windmill.delegate = self
            self.outlineView.setDataSource(self.outlineViewDataSource)
            self.outlineView.setDelegate(self.outlineViewdelegate)
            self.outlineView.registerForDraggedTypes([NSFilenamesPboardType])            
        }
    }
    
    let outlineViewdelegate = ProjectsOutlineViewDelegate()
    lazy var outlineViewDataSource : ProjectsDataSource = {
        let outlineViewDataSource = ProjectsDataSource()
            outlineViewDataSource.projectsViewController = self
            outlineViewDataSource.projects = self.windmill.projects
        return outlineViewDataSource
    }()
    
    /**
     
     Causes the #outlineview to refresh
     
     */
    func reloadData()
    {
        self.outlineView.reloadData()
    }
    
    /// callback from #outlineViewDatasource when a drag operation is performed by the user
    func performDragOperation(info: NSDraggingInfo) -> Bool
    {
        print(__FUNCTION__);
        
        guard let folder = info.draggingPasteboard().firstFilename() else {
            return false
        }
        
        ProjectsViewController.logger.log(.INFO, folder)
        let result = parse(fullPathOfLocalGitRepo: folder)
        
        switch result
        {
        case .Success(let project):
            let wasDeployed = self.windmill.deploy(project)
            
            if(wasDeployed) {
                self.buildProgressIndicator.startAnimation(self)
                
                let commitNumber = "8076c32"
                self.buildTextField.attributedStringValue = NSAttributedString.commitBuildString(commitNumber, branchName: "master")
            }
            
            return true
        case .Failure(let error):
            alert(error, window: self.view.window!)
            return false
        }
    }
    
    func created(windmill: Windmill, projects: Array<Project>, project: Project) {
        self.outlineViewDataSource.projects = projects
    }
}