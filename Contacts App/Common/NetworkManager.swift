//
//  NetworkManager.swift
//  Contacts App
//
//  Created by Yash Bedi on 08/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

internal enum HttpMethod : String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

class NetworkManager {

    private init() { }
    
    static let shared = NetworkManager()

    
    
    // MARK: GET Contacts From Backend
    
    
    internal func getContacts(completionHandler: @escaping ([Contact]?)->Void) {
        
        var request = URLRequest(url: URL(string: "\(Constants.kBaseUrl)/contacts.json")!)
        request.httpMethod = HttpMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, errory -> Void in
            if data != nil {
                do {
                    var contacts = [Contact]()
                    contacts.removeAll()
                    if let contactsFromServer = try JSONSerialization.jsonObject(with: data!) as? Array<Dictionary<String,  Any>>{
                        for c in contactsFromServer {
                            let contact = Contact(from: c)
                            contacts.append(contact)
                        }
                        completionHandler(contacts)
                    }else{
                        completionHandler(nil)
                    }
                } catch {
                    print(Constants.kJSONError,error.localizedDescription)
                    completionHandler(nil)
                }
            }else{
                completionHandler(nil)
            }
        }).resume()
    }
    
    
    
    
    
    // MARK: GET Contact From Backend
    
    
    internal func getContact(from id: Int, completionHandler: @escaping (Contact?)->Void) {
        var request = URLRequest(url: URL(string: "\(Constants.kBaseUrl)/contacts/\(id).json")!)
        request.httpMethod = HttpMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, errory -> Void in
            if data != nil{
                do {
                    if let contactFromServer = try JSONSerialization.jsonObject(with: data!) as? Dictionary<String, Any>{
                        let contact = Contact(from: contactFromServer)
                        completionHandler(contact)
                    }
                } catch {
                    print(Constants.kJSONError,error.localizedDescription)
                    completionHandler(nil)
                }
            }else{
                completionHandler(nil)
            }
            
        }).resume()
    }
    
    internal func getImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    
    // MARK: PUT Contact to Backend
    
    
    
    internal func editContact(for id: Int, with params: [String: Any], completion: @escaping (Contact?) -> () ) {
        
        var request = URLRequest(url: URL(string: "\(Constants.kBaseUrl)/contacts/\(id).json")!)
        request.httpMethod = HttpMethod.put.rawValue
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
        request.httpMethod = HttpMethod.post.rawValue
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
        request.httpMethod = HttpMethod.delete.rawValue
        
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
