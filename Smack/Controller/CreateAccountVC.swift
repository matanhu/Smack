//
//  CreateAccountVC.swift
//  Smack
//
//  Created by MatanHuja on 11/09/2018.
//  Copyright © 2018 Matan Huja. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    @IBAction func closePressed(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
