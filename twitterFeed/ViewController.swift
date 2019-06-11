//
//  ViewController.swift
//  twitterFeed
//
//  Created by Rishabh Bhandari on 04/06/19.
//  Copyright © 2019 Rishabh Bhandari. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var lol = "data-aria-label-part=\"0\">"
    

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    var tweets:[String] = []
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.myTextView.text = tweets[indexPath.row]
        return cell
        
    }
    
    @IBAction func search(_ sender: UIButton) {
        
        if myTextField.text != "" {
            let user = myTextField.text?.replacingOccurrences(of: " ", with: "")
            getStuff(user: user!)
        }
        
    }
    
    func getStuff(user:String) {
        
        let url = URL(string: "https://twitter.com/" + user)
        
        let task = URLSession.shared.dataTask(with: url!) { (data,response,error) in
            if error != nil{
                DispatchQueue.main.async {
                    if let errorMessage = error?.localizedDescription{
                        self.myLabel.text = errorMessage
                    }
                    else {
                        self.myLabel.text = "Error"
                    }
                }
                
            }
            else {
                let webContent = String(data: data!, encoding: String.Encoding.utf8)
                var array:[String] = webContent!.components(separatedBy: "<title>")
                array = array[1].components(separatedBy: " |")
                let name = array[0]
                
                array.removeAll()
                
                array = webContent!.components(separatedBy: "data-resolved-url-large=\"")
                array = array[1].components(separatedBy: "\"")
                let profilePicture = array[0]
                
                array = webContent!.components(separatedBy: self.lol)
                array.remove(at: 0)
                
                for i in 0...array.count-1 {
                    let newTweet = array[i].components(separatedBy: "<")
                    array[i] = newTweet[0]
                }
                self.tweets = array
                
                DispatchQueue.main.async {
                    self.myLabel.text = name
                    self.updateImage(url: profilePicture)
                    self.myTableView.reloadData()
                    
                }
                
            }
            
        }
        task.resume()
    }
    
    func updateImage(url:String) {
        
        let url = URL(string: url)
        let task = URLSession.shared.dataTask(with: url!) {(data,response,error) in
            DispatchQueue.main.async {
                self.myImageView.image = UIImage(data: data!)
                
            }
        }
        task.resume()
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

