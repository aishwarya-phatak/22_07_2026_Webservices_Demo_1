//
//  ViewController.swift
//  22_07_2026_Webservices_Demo_1
//
//  Created by Vishal Jagtap on 01/10/26.
//

import UIKit

class ViewController: UIViewController {
    
    var users : [User] = []             //empty array of users
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
    
    func fetchUsers(){
        urlRequest = URLRequest(url: Constants.url!)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession?.dataTask(with: urlRequest!) { data, res, err in
            print("Data : \(data!)")
            print("Err  : \(err)")
            print("Res : \(res!)")
            
            //try , try! , try?  --> these are three try statements
            
            do{
                var jsonResponse = try JSONSerialization.jsonObject(with: data!) as? [[String : Any]]
                print(jsonResponse)
                
                for eachUser in jsonResponse!{
                    let eachUser = eachUser as! [String:Any]
                   // print(eachUser)
                    let eachUserId = eachUser["userId"] as? Int
                    let eachId = eachUser["id"] as? Int
                    let eachUserTitle = eachUser["title"] as? String
                    let eachUserBody = eachUser["body"] as? String
                }
            }catch{
                print("There is an error")
            }
        }
        dataTask?.resume()
    }
    
}
