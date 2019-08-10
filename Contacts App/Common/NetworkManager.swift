//
//  NetworkManager.swift
//  Contacts App
//
//  Created by Yash Bedi on 08/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

class NetworkManager {

    private init() { }
    
    static let shared = NetworkManager()

    
    // MARK: GET Contacts From Backend
    
    internal func get(from url: URL, completion: @escaping _dataBlock) {
        var request = URLRequest(url: url)
        request.httpMethod = http.get.rawValue
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, errory -> Void in
            guard let _data = data else { completion(nil); return }
            completion(_data)
        }).resume()
    }
    
    // MARK: Get Image From URL
    
    internal func getImage(from url: URL, completion: @escaping (Data)->Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _data = data { completion(_data) }
        }.resume()
    }
    
    
    // MARK: PUT Contact to Backend
    
    
    internal func editContact(for id: Int, with params: [String: Any], completion: @escaping (Contact?) -> () ) {
        
        var request = URLRequest(url: URL(string: "\(Constants.kBaseUrl)/contacts/\(id).json")!)
        request.httpMethod = http.put.rawValue
        request.addValue(Constants.kHeaderValue, forHTTPHeaderField: Constants.kHeaderType)
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, errory -> Void in
            if data != nil {
                do {
                    let result = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, Any>
                    let contact = Contact(from: result)
                    completion(contact)
                } catch {
                    print(Constants.kJSONError,error.localizedDescription)
                    completion(nil)
                }
            }else{
                completion(nil)
            }
        }).resume()
    }
    
    // MARK: POST Contact to Backend
    
    internal func addContact(with params: [String: Any], completion: @escaping (String?) -> ()){
        
        var request = URLRequest(url: URL(string: "\(Constants.kBaseUrl)/contacts.json")!)
        request.httpMethod = http.post.rawValue
        request.addValue(Constants.kHeaderValue, forHTTPHeaderField: Constants.kHeaderType)
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, errory -> Void in
        
            if let status = response as? HTTPURLResponse{
            
                if status.statusCode == 200 || status.statusCode == 201 {
                    print(Constants.kSuccess)
                    completion(Constants.kSuccess)
                }else{
                    print(status.statusCode)
                    completion(nil)
                }
            }else{
                completion(nil)
            }
        }).resume()
    }
    
    
    // MARK: DELETE Contact From Backend
    
    
    internal func deleteContact(with id: Int, completion: @escaping (String?) -> ()){
        
        var request = URLRequest(url: URL(string: "\(Constants.kBaseUrl)/contacts/\(id).json")!)
        request.httpMethod = http.delete.rawValue
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, errory -> Void in
            
            if let status = response as? HTTPURLResponse{
                
                if status.statusCode == 200 || status.statusCode == 204 {
                    print(Constants.kSuccess)
                    completion(Constants.kSuccess)
                }else{
                    print(status.statusCode)
                    completion(nil)
                }
            }else{
                completion(nil)
            }
        }).resume()
    }
}
