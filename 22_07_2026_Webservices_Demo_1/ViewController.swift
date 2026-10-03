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
    let reuseIdentifierForCell = "UserTableViewCell"
    let reuseIdentifierForViewConroller = "SecondViewController"
    
    @IBOutlet weak var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        initViews()
        registerCellWithTableView()
    }
    
    func initViews(){
        usersTableView.delegate = self
        usersTableView.dataSource = self
    }
    
    func registerCellWithTableView(){
        let uiNib = UINib(nibName: reuseIdentifierForCell, bundle: nil)
        self.usersTableView.register(uiNib, forCellReuseIdentifier: reuseIdentifierForCell)
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
                    
                    //swift object
                    let eachUserObject = User(userId: eachUserId!,
                                              id: eachId!,
                                              title: eachUserTitle!,
                                              body: eachUserBody!)
                    
                    self.users.append(eachUserObject)
                    //print("users array in swift : ",self.users)
                }
            }catch{
                print("There is an error")
            }
            
            //imporatnt - reloading of table view
            
            DispatchQueue.main.async{
                self.usersTableView.reloadData()
            }
        }
        dataTask?.resume()
    }
    
}

//MARK : UITableViewDelegate
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: reuseIdentifierForViewConroller) as? SecondViewController
        
        secondViewController?.userContainer = users[indexPath.row]
        self.navigationController?.pushViewController(secondViewController!, animated: true)
    }
}

//MARK : UITableViewDataSource
extension ViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userTableViewCell = self.usersTableView.dequeueReusableCell(withIdentifier: reuseIdentifierForCell, for: indexPath) as? UserTableViewCell
        
        userTableViewCell?.userIdLabel.text = "\(users[indexPath.row].userId)"
        userTableViewCell?.userTitleLabel.text = users[indexPath.row].title
        userTableViewCell?.userBodyLabel.text = users[indexPath.row].body
        
        return userTableViewCell!
    }
}
