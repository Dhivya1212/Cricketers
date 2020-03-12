//
//  APIHandler.swift
//  Cricketers
//
//  Created by Adaikalraj on 11/03/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

typealias completionHandler = (_ error : Error? , _ responseJSON : [String:Any]? , _ urlResponse : URLResponse?) -> Void

class APIHandler: NSObject {
    
    public static func getResponse(url : String , method : String , json : Data? , completionHandler : @escaping completionHandler){
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        
        urlRequest.httpMethod = method
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        if(json != nil)
        {
            urlRequest.httpBody = json
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completionHandler(error!,nil,nil)
            }
            else
            {
                let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    if let httpResponse = response as? HTTPURLResponse {
                        completionHandler(error,responseJSON,httpResponse)
                    }
                    else{
                        completionHandler(error,responseJSON,nil)
                    }
                }
                else {
                    completionHandler(error,nil,response!)
                }
            }
        }
        task.resume()
    }
    
}
