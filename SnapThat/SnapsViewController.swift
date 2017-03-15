//
//  SnapsViewController.swift
//  SnapThat
//
//  Created by Chris Smith on 09/03/2017.
//  Copyright © 2017 CDSApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var snaps : [Snap] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        FIRDatabase.database().reference().child("Users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            
            let snap = Snap()
            snap.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.descrip = (snapshot.value as! NSDictionary)["description"] as! String
            
            self.snaps.append(snap)
            
            self.tableView.reloadData()
            
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let snap = snaps[indexPath.row]
        
        cell.textLabel?.text = snap.from
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnapSegue" {
        
        let nextVC = segue.destination as! ViewSnapViewController
        
        nextVC.snap = sender as! Snap
    }
    }
    

    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        
    }
    

}




























