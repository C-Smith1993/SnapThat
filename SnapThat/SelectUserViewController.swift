//
//  SelectUserViewController.swift
//  SnapThat
//
//  Created by Chris Smith on 14/03/2017.
//  Copyright © 2017 CDSApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    
    var imageURL = ""
    var descrip = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        FIRDatabase.database().reference().child("Users").observe(FIRDataEventType.childAdded, with: {(snapshot) in
        let user = User()
            user.email = (snapshot.value as! NSDictionary) ["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            
            self.tableView.reloadData()
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        let snap = ["from": user.email, "description": descrip, "imageURL": imageURL]
        
        FIRDatabase.database().reference().child("Users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
    }

}


















