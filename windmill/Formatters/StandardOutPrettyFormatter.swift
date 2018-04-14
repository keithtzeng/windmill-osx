//
//  PrettyFormatter.swift
//  windmill
//
//  Created by Markos Charatzas on 12/4/18.
//  Copyright © 2018 qnoid.com. All rights reserved.
//

import Foundation

class StandardOutPrettyFormatter: Formatter {
    
    let checkoutSuccessFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let buildTargetFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let writeAuxiliaryfilesFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let createProductStructureFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let compileSwiftSourcesFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let mergeModulesCommandFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let compileFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let compileErrorFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let noteFormatter = RegularExpressionMatchesFormatter<String>.makeNote()
    let copyUsingDittoFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let createUniversalBinaryFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let compileXIBFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let compileStoryboardFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let compileAssetCatalogFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let processInfoPlistFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let pbxcpFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let generateDSYMFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let linkStoryboardsFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let phaseScriptExecutionFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let copyStandardLibrariesFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let touchFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let processProductPackagingFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let linkingFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let codeSignFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let phaseSuccessFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let phaseFailureFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let testSuiteAllTestsStartedFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let testSuiteXctestStartedFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let testSuiteStartedFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let testCasePassedFormatter: RegularExpressionMatchesFormatter<NSAttributedString>
    let testCaseFailedFormatter: RegularExpressionMatchesFormatter<NSAttributedString>

    let descender: CGFloat
    
    init(descender: CGFloat, compileFormatter: RegularExpressionMatchesFormatter<NSAttributedString>) {
        self.descender = descender
        self.checkoutSuccessFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCheckoutSuccess(descender: descender)
        self.buildTargetFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeBuildTarget(descender: descender)
        self.writeAuxiliaryfilesFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeWriteAuxiliaryfiles(descender: descender)
        self.createProductStructureFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCreateProductStructure(descender: descender)
        self.compileFormatter = compileFormatter
        self.compileErrorFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCompileError(descender: descender)
        self.compileSwiftSourcesFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCompileSwiftSources(descender: descender)
        self.compileXIBFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCompileXIB(descender: descender)
        self.compileStoryboardFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCompileStoryboard(descender: descender)
        self.compileAssetCatalogFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCompileAssetCatalog(descender: descender)
        self.processInfoPlistFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeProcessInfoPlist(descender: descender)
        self.mergeModulesCommandFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeMergeModulesCommand(descender: descender)
        self.copyUsingDittoFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCopyUsingDitto(descender: descender)
        self.createUniversalBinaryFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCreateUniversalBinary(descender: descender)
        self.pbxcpFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makePBXCP(descender: descender)
        self.generateDSYMFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeGenerateDSYM(descender: descender)
        self.linkStoryboardsFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeLinkStoryboards(descender: descender)
        self.phaseScriptExecutionFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makePhaseScriptExecution(descender: descender)
        self.copyStandardLibrariesFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCopyStandardLibraries(descender: descender)
        self.touchFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTouch(descender: descender)
        self.processProductPackagingFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeProcessProductPackaging(descender: descender)
        self.linkingFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeLinking(descender: descender)
        self.codeSignFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCodeSign(descender: descender)
        self.phaseSuccessFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makePhaseSuccess(descender: descender)
        self.phaseFailureFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makePhaseFailure(descender: descender)
        self.testSuiteAllTestsStartedFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTestSuiteAllTestsStarted(descender: descender)
        self.testSuiteXctestStartedFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTestSuiteXctestStarted(descender: descender)
        self.testSuiteStartedFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTestSuiteStarted(descender: descender)
        self.testCasePassedFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTestCasePassed(descender: descender)
        self.testCaseFailedFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTestCaseFailed(descender: descender)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.descender = 0.0
        self.checkoutSuccessFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCheckoutSuccess(descender: descender)
        self.buildTargetFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeBuildTarget(descender: descender)
        self.writeAuxiliaryfilesFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeWriteAuxiliaryfiles(descender: descender)
        self.createProductStructureFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCreateProductStructure(descender: descender)
        self.compileFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCompile(descender: descender)
        self.compileErrorFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCompileError(descender: descender)
        self.compileXIBFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCompileXIB(descender: descender)
        self.compileStoryboardFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCompileStoryboard(descender: descender)
        self.compileAssetCatalogFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCompileAssetCatalog(descender: descender)
        self.processInfoPlistFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeProcessInfoPlist(descender: descender)
        self.mergeModulesCommandFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeMergeModulesCommand(descender: descender)
        self.compileSwiftSourcesFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCompileSwiftSources(descender: descender)
        self.copyUsingDittoFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCopyUsingDitto(descender: descender)
        self.createUniversalBinaryFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCreateUniversalBinary(descender: descender)
        self.pbxcpFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makePBXCP(descender: descender)
        self.generateDSYMFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeGenerateDSYM(descender: descender)
        self.linkStoryboardsFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeLinkStoryboards(descender: descender)
        self.phaseScriptExecutionFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makePhaseScriptExecution(descender: descender)
        self.copyStandardLibrariesFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCopyStandardLibraries(descender: descender)
        self.touchFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTouch(descender: descender)
        self.processProductPackagingFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeProcessProductPackaging(descender: descender)
        self.linkingFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeLinking(descender: descender)
        self.codeSignFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeCodeSign(descender: descender)
        self.phaseSuccessFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makePhaseSuccess(descender: descender)
        self.phaseFailureFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makePhaseFailure(descender: descender)
        self.testSuiteAllTestsStartedFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTestSuiteAllTestsStarted(descender: descender)
        self.testSuiteXctestStartedFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTestSuiteXctestStarted(descender: descender)
        self.testSuiteStartedFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTestSuiteStarted(descender: descender)
        self.testCasePassedFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTestCasePassed(descender: descender)
        self.testCaseFailedFormatter = RegularExpressionMatchesFormatter<NSAttributedString>.makeTestCaseFailed(descender: descender)
        super.init(coder: aDecoder)
    }
    
    override func string(for obj: Any?) -> String? {
        if let note = noteFormatter.format(for: obj) {
            return note
        } else {
            return nil
        }
    }
    
    override func attributedString(for obj: Any, withDefaultAttributes attrs: [NSAttributedStringKey : Any]? = nil) -> NSAttributedString? {
        if let checkoutSuccess = self.checkoutSuccessFormatter.format(for: obj) {
            return checkoutSuccess
        }else if let buildTarget = self.buildTargetFormatter.format(for: obj) {
            return buildTarget
        } else if let compile = self.compileFormatter.format(for: obj) {
            return compile
        } else if let writeAuxiliaryfiles = self.writeAuxiliaryfilesFormatter.format(for: obj) {
            return writeAuxiliaryfiles
        } else if let createProductStructure = self.createProductStructureFormatter.format(for: obj) {
            return createProductStructure
        } else if let compileSwiftSources = self.compileSwiftSourcesFormatter.format(for: obj) {
            return compileSwiftSources
        } else if let copyUsingDitto = self.copyUsingDittoFormatter.format(for: obj) {
            return copyUsingDitto
        } else if let compileAssetCatalog = self.compileAssetCatalogFormatter.format(for: obj) {
            return compileAssetCatalog
        } else if let processInfoPlist = self.processInfoPlistFormatter.format(for: obj) {
            return processInfoPlist
        } else if let createUniversalBinary = self.createUniversalBinaryFormatter.format(for: obj) {
            return createUniversalBinary
        } else if let phaseSuccess = self.phaseSuccessFormatter.format(for: obj) {
            return phaseSuccess
        } else if let compileError = self.compileErrorFormatter.format(for: obj) {
            return compileError
        } else if let mergeModulesCommand = self.mergeModulesCommandFormatter.format(for: obj) {
            return mergeModulesCommand
        } else if let compileXIB = self.compileXIBFormatter.format(for: obj) {
            return compileXIB
        } else if let compileStoryboard = self.compileStoryboardFormatter.format(for: obj) {
            return compileStoryboard
        } else if let pbxcp = self.pbxcpFormatter.format(for: obj) {
            return pbxcp
        } else if let touch = self.touchFormatter.format(for: obj) {
            return touch
        } else if let codeSign = self.codeSignFormatter.format(for: obj) {
            return codeSign
        } else if let generateDSYM = self.generateDSYMFormatter.format(for: obj) {
            return generateDSYM
        } else if let linkStoryboards = self.linkStoryboardsFormatter.format(for: obj) {
            return linkStoryboards
        } else if let phaseScriptExecution = self.phaseScriptExecutionFormatter.format(for: obj) {
            return phaseScriptExecution
        } else if let copyStandardLibraries = self.copyStandardLibrariesFormatter.format(for: obj) {
            return copyStandardLibraries
        } else if let processProductPackaging = self.processProductPackagingFormatter.format(for: obj) {
            return processProductPackaging
        } else if let linking = self.linkingFormatter.format(for: obj) {
            return linking
        } else if let phaseFailure = self.phaseFailureFormatter.format(for: obj) {
            return phaseFailure
        } else if let testSuiteAllTestsStarted = self.testSuiteAllTestsStartedFormatter.format(for: obj) {
            return testSuiteAllTestsStarted
        } else if let testSuiteXctestStarted = self.testSuiteXctestStartedFormatter.format(for: obj) {
            return testSuiteXctestStarted
        } else if let testSuiteStarted = self.testSuiteStartedFormatter.format(for: obj) {
            return testSuiteStarted
        } else if let testCasePassed = self.testCasePassedFormatter.format(for: obj) {
            return testCasePassed
        } else if let testCaseFailed = self.testCaseFailedFormatter.format(for: obj) {
            return testCaseFailed
        } else {
            return nil
        }
    }
}
