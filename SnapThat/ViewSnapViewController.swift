//
//  ViewSnapViewController.swift
//  SnapThat
//
//  Created by Chris Smith on 15/03/2017.
//  Copyright © 2017 CDSApps. All rights reserved.
//

import UIKit
import SDWebImage

class ViewSnapViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    var snap = Snap()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = snap.descrip
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))
    }

 

}
