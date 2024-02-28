//
//  ViewController.swift
//  createAPI
//
//  Created by albert Michael on 20/02/24.
//

import UIKit
import Alamofire
import ObjectMapper

class ViewController: UIViewController {

    var loginView        : LoginViewModel?
    
    
    
    @IBOutlet weak var responselbl: UILabel!
    
    @IBOutlet weak var tokenlbl: UILabel!
    
    @IBOutlet weak var emaillbl: UILabel!
    
    @IBOutlet weak var loginlbl: UILabel!
    
    @IBOutlet weak var idlbl: UILabel!
    
    @IBOutlet weak var namelbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        LoginApi()
       
            self.urlsessionapi()
        
    }

    func LoginApi() {
      
        let headers: HTTPHeaders = [
            
        ]
        
        let parameters: [String: Any] = [
            "user_email": "abc@gmail.com",
            "login_type": "gmail",
            "social_id": "",
            "user_name": "abc",
            
            // Add other subscription parameters as needed
        ]
        
        AF.request("http://13.232.9.95:7302/vivyacards_app/logging/email_verify/", method: .post, parameters: parameters,encoding: JSONEncoding.default).responseJSON { [self] response in
           

            switch (response.response?.statusCode) {
                
            case 200 :
                
                switch response.result {
                    
                case let .success(value):
                    
                   print(value)
                    loginView = Mapper<LoginViewModel>().map(JSON: value as! [String : Any])
                    
                    let response_code = loginView!.response_code
                    let token = loginView?.loginData[0].token
                    let  useremail = loginView?.loginData[0].user?.user_email
                    let firstloagin = loginView!.loginData[0].user!.first_login
                    let userid = loginView?.loginData[0].user!.user_id
                    let username = loginView?.loginData[0].user?.user_name
                    
                    self.responselbl.text  = "\(response_code ?? 0)"
                    self.tokenlbl.text = token
                    self.emaillbl.text = useremail
                    self.loginlbl.text = "\(firstloagin ?? true)"
                    self.idlbl.text = "\(userid ?? 0)"
                    self.namelbl.text = username
                    print(response_code ?? "")
                    print(token ?? "")
                    print(useremail ?? "")
                    print(firstloagin ?? "")
                    print(userid ?? "")
                    print(username ?? "")
                  
                    
                   
                case let .failure(error):
                    print(error)
                }
            case 401: break
              
            default: break
                
              }
        }
    }
    
    func urlsessionapi() {
        
        let apiUrlString = "http://13.232.9.95:7302/vivyacards_app/logging/email_verify/"
        guard let apiUrl = URL(string: apiUrlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        
        // Set up parameters
        let parameters: [String: Any] = [
            "user_email": "abc@gmail.com",
            "login_type": "gmail",
            "social_id": "",
            "user_name": "abc"
            // Add other parameters as needed
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error creating HTTP body: \(error)")
            return
        }
        
        // Set content type to JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                // Parse the JSON response
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                self.loginView = Mapper<LoginViewModel>().map(JSON: json as! [String : Any])
                
                let response_code = self.loginView!.response_code
                let token = self.loginView?.loginData[0].token
                let  useremail = self.loginView?.loginData[0].user?.user_email
                let firstloagin = self.loginView!.loginData[0].user!.first_login
                let userid = self.loginView?.loginData[0].user!.user_id
                let username = self.loginView?.loginData[0].user?.user_name
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.responselbl.text  = "\(response_code ?? 0)"
                    self.tokenlbl.text = token
                    self.emaillbl.text = useremail
                    self.loginlbl.text = "\(firstloagin ?? true)"
                    self.idlbl.text = "\(userid ?? 0)"
                    self.namelbl.text = username
                }
                print(response_code ?? "")
                print(token ?? "")
                print(useremail ?? "")
                print(firstloagin ?? "")
                print(userid ?? "")
                print(username ?? "")
                print(json)
                
                // Handle the response as needed
                // ...
                
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
        
        task.resume()
    }

    
    @IBAction func sumbit(_ sender: Any) {
        
        
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
         
        
         // Now, animate the transition to the final view controller (EditProfileViewController)
         self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

