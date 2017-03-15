//
//  ViewSnapViewController.swift
//  SnapThat
//
//  Created by Chris Smith on 15/03/2017.
//  Copyright © 2017 CDSApps. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = snap.descrip
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
         FIRDatabase.database().reference().child("Users").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        FIRStorage.storage().reference().child("Images").child("\(snap.uuid).jpg").delete { (error) in
            print("We deleted the pic")
        }
    }

 

}
