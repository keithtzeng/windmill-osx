//
//  SequenceTest.swift
//  windmillTests
//
//  Created by Markos Charatzas on 8/2/18.
//  Copyright © 2018 qnoid.com. All rights reserved.
//

import XCTest

@testable import windmill

class SequenceTest: XCTestCase {

    let bundle = Bundle(for: SequenceTest.self)
    
    func testGivenProjectWithoutTestTargetAssertTestWasSuccesful() {
        
        let expectation = self.expectation(description: #function)
        let processManager = ProcessManager()
        
        let name = "helloword-no-test-target"
        let project = Project(name: name, scheme: "helloword-no-test-target", origin: "any")
        let directoryPath = bundle.url(forResource: name, withExtension: "")!.path

        let devices = Devices(metadata: MetadataJSONEncoded(url: bundle.url(forResource: "/metadata/\(name)/test/devices", withExtension: "json")!))
        let buildSettings = BuildSettings(metadata: MetadataJSONEncoded(url: bundle.url(forResource: "/metadata/\(name)/build/settings", withExtension: "json")!))
        
        let build = Process.makeBuild(directoryPath: directoryPath, project: project, devices: devices)
        let readTestMetadata = Process.makeReadDevices(directoryPath: directoryPath, forProject: project, devices: devices, buildSettings: buildSettings)
        let test = Process.makeTest(directoryPath: directoryPath, project: project, devices: devices)
        
        processManager.sequence(process: build, wasSuccesful: DispatchWorkItem {
            processManager.sequence(process: readTestMetadata, wasSuccesful: DispatchWorkItem {
                processManager.sequence(process: test, wasSuccesful: DispatchWorkItem {
                    expectation.fulfill()
                }).launch()
            }).launch()
        }).launch()

        wait(for: [expectation], timeout: 30.0)
    }
    
    func testGivenProjectWithTestTargetAssertTestWasSuccesful() {
        
        let expectation = self.expectation(description: #function)
        let processManager = ProcessManager()
        
        let name = "helloworld"
        
        let project = Project(name: name, scheme: "helloworld", origin: "any")
        let directoryPath = project.directoryPathURL.path
        
        let devices = Devices(metadata: MetadataJSONEncoded(url: bundle.url(forResource: "/metadata/\(name)/test/devices", withExtension: "json")!))
        let buildSettings = BuildSettings(metadata: MetadataJSONEncoded(url: bundle.url(forResource: "/metadata/\(name)/build/settings", withExtension: "json")!))
        
        let build = Process.makeBuild(directoryPath: directoryPath, project: project, devices: devices)
        let readTestMetadata = Process.makeReadDevices(directoryPath: directoryPath, forProject: project, devices: devices, buildSettings: buildSettings)
        let test = Process.makeTest(directoryPath: directoryPath, project: project, devices: devices)
        
        processManager.sequence(process: build, wasSuccesful: DispatchWorkItem {
            processManager.sequence(process: readTestMetadata, wasSuccesful: DispatchWorkItem {
                processManager.sequence(process: test, wasSuccesful: DispatchWorkItem {
                    expectation.fulfill()
                }).launch()
            }).launch()
        }).launch()
        
        wait(for: [expectation], timeout: 60.0)
    }

    func testGivenProjectWithoutAvailableSimulatorAssertTestWasSuccesful() {
        
        let expectation = self.expectation(description: #function)
        let processManager = ProcessManager()
        
        let name = "no_simulator_available"
        let project = Project(name: name, scheme: "no_simulator_available", origin: "any")
        let directoryPath = bundle.url(forResource: name, withExtension: "")!.path
        
        let devices = Devices(metadata: MetadataJSONEncoded(url: bundle.url(forResource: "/metadata/\(name)/test/devices", withExtension: "json")!))
        let buildSettings = BuildSettings(metadata: MetadataJSONEncoded(url: bundle.url(forResource: "/metadata/\(name)/build/settings", withExtension: "json")!))
        
        let build = Process.makeBuild(directoryPath: directoryPath, project: project, devices: devices)
        let readTestMetadata = Process.makeReadDevices(directoryPath: directoryPath, forProject: project, devices: devices, buildSettings: buildSettings)
        let test = Process.makeTest(directoryPath: directoryPath, project: project, devices: devices)
        
        processManager.sequence(process: build, wasSuccesful: DispatchWorkItem {
            processManager.sequence(process: readTestMetadata, wasSuccesful: DispatchWorkItem {
                processManager.sequence(process: test, wasSuccesful: DispatchWorkItem {
                    expectation.fulfill()
                }).launch()
            }).launch()
        }).launch()
        
        wait(for: [expectation], timeout: 30.0)
    }
}
