//
//  APIManager.swift
//  Task
//
//  Created by Mostafa Abd ElFatah on 6/26/19.
//  Copyright © 2019 Mostafa Abd ElFatah. All rights reserved.
//

import UIKit
import Alamofire

protocol FetchUserDataDelegate {
    func complete(response:Auth)
    func failed(error:String)
}

class APIManager {
    
    public static let sharedInstance = APIManager()
    
    // MARK: - Login to server
    
    func loginUser(params:[String:String] ,responseDelegate:FetchUserDataDelegate?){
        
        Alamofire.request(URLs.loginUrl, method: .post, parameters: params,encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                guard  let delegate =  responseDelegate else {return}
                switch response.result {
                case .failure(let error):
                    delegate.failed(error: error.localizedDescription)
                    break
                case .success:
                    guard let data = response.data else {return}
                    do {
                        let auth:Auth = try JSONDecoder().decode(Auth.self, from: data)
                        delegate.complete(response: auth)
                    } catch {
                        delegate.failed(error: error.localizedDescription)
                        print(error)
                    }
                    
                }
                
        }
        
    }
    
    
    
}

