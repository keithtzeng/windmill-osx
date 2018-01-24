//
//  Export.swift
//  windmill
//
//  Created by Markos Charatzas on 24/1/18.
//  Copyright © 2018 qnoid.com. All rights reserved.
//

import Foundation

struct Export {
    
    struct DistributionSummary {
        
        public static func make(for project:Project) -> DistributionSummary {
            
            let url = FileManager.default.exportDirectoryURL(forProject: project.name).appendingPathComponent("DistributionSummary.plist")
            
            return DistributionSummary(project: project, metadata: MetadataPlistEncoded(url: url))
        }
        
        
        let project: Project
        let metadata: Metadata
        
        var dictionary:[String:Any]? {
            
            guard let key = self.key else {
                return nil
            }
            
            let array:[[String:Any]]? = metadata[key]
            
            return array?[0]
        }
        
        var key: String? {
            return metadata.dictionary?.keys.first
        }
        
        var team: [String: String]? {
            return dictionary?["team"] as? [String: String]
        }
        
        var certificate: [String: String]? {
            return dictionary?["certificate"] as? [String: String]
        }
        
        var profile: [String: String]? {
            return dictionary?["profile"] as? [String: String]
        }
        
        var teamId: String {
            return team?["id"] ?? ""
        }
        
        var teamName: String {
            return team?["name"] ?? ""
        }
        
        var certificateType: String {
            return certificate?["type"] ?? ""
        }
        
        var profileName: String {
            return profile?["name"] ?? ""
        }
    }

    struct Manifest {

        public static func make(for project:Project) -> Manifest {
            
            let url = FileManager.default.exportDirectoryURL(forProject: project.name).appendingPathComponent("manifest.plist")
            
            return Manifest(project: project, metadata: MetadataPlistEncoded(url: url))
        }
        

        let project: Project
        let metadata: Metadata

        var items:[String:Any]? {
            let items:[[String:Any]]? = metadata["items"]
            
            return items?[0]
        }

        var bundleIdentifier: String {
            let metadata = items?["metadata"] as? [String: String]
            
            return metadata?["bundle-identifier"] ?? ""
        }
        
        var bundleVersion: String {
            let metadata = items?["metadata"] as? [String: String]
            
            return metadata?["bundle-version"] ?? ""
        }
        
        var title: String {
            let metadata = items?["metadata"] as? [String: String]
            
            return metadata?["title"] ?? ""
        }
    }
    
    static func make(forProject project: Project) -> Export {
        let distributionSummary = Export.DistributionSummary.make(for: project)
        let manifest = Export.Manifest.make(for: project)
        let exportURL = FileManager.default.exportURL(forProject: project)

        return Export(url: exportURL, manifest: manifest, distributionSummary: distributionSummary)
    }
    
    let url: URL
    let manifest: Manifest
    let distributionSummary: DistributionSummary
}

extension Export {
    
    var name: String {
        return self.distributionSummary.key ?? self.url.lastPathComponent
    }
}

