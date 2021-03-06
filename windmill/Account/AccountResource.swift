//
//  AccountResource.swift
//  windmill
//
//  Created by Markos Charatzas (markos@qnoid.com) on 06/03/2019.
//  Copyright © 2014-2020 qnoid.com. All rights reserved.
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation is required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source distribution.
//

import Foundation

import Foundation
import os
import Alamofire

class AccountResource {
    
    typealias ExportCompletion = (_ itms: String?, _ error: Error?) -> Void
    typealias FailureCase = (_ error: Error, _ response: Alamofire.DataResponse<Data>) -> Swift.Void

    let queue = DispatchQueue(label: "io.windmill.windmill.manager")
    
    let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        
        return URLSession(configuration: configuration)
    }()
    
    let sessionManager = SessionManager()
    
    func failureCase(completion: @escaping AccountResource.ExportCompletion) -> FailureCase {
        return { error, response in
            switch error {
            case let error as AFError where error.isResponseSerializationError:
                DispatchQueue.main.async{
                    completion(nil, error.underlyingError)
                }
            case let error as AFError where error.isResponseValidationError:
                switch (error.responseCode, response.data) {
                case (401, let data?):
                    if let response = String(data: data, encoding: .utf8), let reason = SubscriptionError.UnauthorisationReason(rawValue: response) {
                        DispatchQueue.main.async{
                            completion(nil, SubscriptionError.unauthorised(reason:reason))
                        }
                    } else {
                        DispatchQueue.main.async{
                            completion(nil, SubscriptionError.unauthorised(reason: nil))
                        }
                    }
                default:
                    DispatchQueue.main.async{
                        completion(nil, error)
                    }
                }
            default:
                DispatchQueue.main.async{
                    completion(nil, error)
                }
            }
        }
    }

    func requestExport(export: Export, metadata: Export.Metadata, forAccount account: Account, authorizationToken: SubscriptionAuthorizationToken, completion: @escaping ExportCompletion) {
        
        var urlRequest = try! URLRequest(url: "\(WINDMILL_BASE_URL)/account/\(account.identifier)/export", method: .post)
        urlRequest.addValue("Bearer \(authorizationToken.value)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 //seconds
        
        return sessionManager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(export.manifest.url, withName: "plist")
        }, with: urlRequest, queue: self.queue, encodingCompletion: { result in
            switch result {
            case .success(let upload, _, _):                
                let postManifest =
                    AccountResourcePostManifest(queue: self.queue).success(request: upload, completion: completion, failureCase: self.failureCase(completion: completion))
                let putExport =
                    AccountResourcePutExport(sessionManager: self.sessionManager).success(export: export, completion: completion)
                let patchExport =
                    AccountResourcePatchExport(sessionManager: self.sessionManager)
                        .make(account: account, metadata: metadata, authorizationToken: authorizationToken, completion: completion, failureCase: self.failureCase(completion: completion))

                let uploadExport = postManifest(putExport(patchExport))
                
                uploadExport([:])
            case .failure(let error):
                DispatchQueue.main.async{
                    completion(nil, error)
                }
            }
        })
    }
}
