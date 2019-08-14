//
//  SCNetworkManager.swift
//  SCWeiboAssistant
//
//  Created by Stephen Cao on 20/4/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import Alamofire

class SCNetworkManager{
    static let shared = SCNetworkManager()
    
    var userLogon: Bool = false
   
    private init() {
        
    }
    
    /// send request with token
    ///
    /// - Parameters:
    ///   - urlString: url in string
    ///   - method: get/ post
    ///   - params: parameters in dictionary
    ///   - name: name in server, like: "pic" for upload
    ///   - data: file in data for upload
    ///   - completion: json(array/ dictionary), isSuccess
    func requestWithToken(urlString: String,method: HTTPMethod,params:[String:Any]?, headers: [String: String], name: String? = nil, dataList: [Data]? = nil, completion:@escaping (_ data: Data?, _ list:Any?, _ isSuccess: Bool)->()){
        if let name = name,
            let dataList = dataList{
            // if name & data are not nil, use upload function
            upload(urlString: urlString, name: name, params: params, dataList: dataList, headers: headers) { (data, res, isSuccess, statusCode, _) in
                if statusCode == 400 {
                    // send notification for relogin
                    completion(nil,nil,false)
                    return
                }
                completion(data,res,isSuccess)
            }
        }else{
            requestInHeader(urlString: urlString, method: method, params: params,headers: headers) { (data, res, isSuccess, statusCode, _) in
                if statusCode == 400 {
                    // send notification for relogin
                    completion(nil,nil,false)
                    return
                }
                completion(data,res,isSuccess)
            }
        }
    }
    func requestInHeader(urlString:String, method:HTTPMethod, params:[String:Any]?,headers: [String: String], completion :@escaping (_ data: Data?, _ response: Any?,_ isSuccess: Bool, _ statusCode: Int,_ error: Error?)->() ){
        Alamofire.request(urlString, method: method, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (dataResponse) in
            completion(
                dataResponse.data,
                dataResponse.result.value,
                dataResponse.result.isSuccess,
                dataResponse.response?.statusCode ?? -1,
                dataResponse.result.error)
        }
    }
    
    /// request method
    ///
    /// - Parameters:
    ///   - urlString: url in string
    ///   - method: get/ post
    ///   - params: parameters in dictionary
    ///   - completion: json(array/ dictionary), isSuccess, error
    func request(urlString:String, method:HTTPMethod, params:[String:Any]?, completion :@escaping (_ data: Data?, _ response: Any?,_ isSuccess: Bool, _ statusCode: Int,_ error: Error?)->() ){
        Alamofire.request(urlString, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (dataResponse) in
            completion(
                dataResponse.data,
                dataResponse.result.value,
                dataResponse.result.isSuccess,
                dataResponse.response?.statusCode ?? -1,
                dataResponse.result.error)
            
        }
    }
    func requestForResponseString(urlString:String, method:HTTPMethod, params:[String:Any]?, completion :@escaping (_ data: Data?, _ response: Any?,_ isSuccess: Bool, _ statusCode: Int,_ error: Error?)->() ){
        Alamofire.request(urlString, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).responseString { (dataResponse) in
            completion(
                dataResponse.data,
                dataResponse.result.value,
                dataResponse.result.isSuccess,
                dataResponse.response?.statusCode ?? -1,
                dataResponse.result.error)
        }
    }
    
    /// Upload a file to server
    ///
    /// - Parameters:
    ///   - urlString: url in string
    ///   - name: name in server, like: "pic"
    ///   - params: a dictionary for parameters
    ///   - data: file in data
    ///   - completion: response in json / nil
    func upload(urlString: String, name: String, params: [String: Any]?,dataList: [Data],headers: [String: String], completion:@escaping (_ data: Data?, _ response: Any?,_ isSuccess: Bool, _ statusCode: Int,_ error: Error?)->()){
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for imageData in dataList{
                multipartFormData.append(
                    imageData,
                    withName: name,
                    fileName: "\(Date().timeIntervalSince1970).png",
                    mimeType: "application/octet-stream")
            }
            for (key,value) in params ?? [:]{
                multipartFormData.append(
                    (value as! String).data(using: String.Encoding.utf8)!,
                    withName: key)
            }
        }, usingThreshold: UInt64.init(),
           to: urlString,
           method: .post,
           headers: headers) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    completion(
                        response.data,
                        response.result.value,
                        response.result.isSuccess,
                        response.response?.statusCode ?? -1,
                        response.result.error)
                }
            case .failure(let encodingError):
                completion(nil, nil, false, -1, encodingError)
            }
        }
    }
}

