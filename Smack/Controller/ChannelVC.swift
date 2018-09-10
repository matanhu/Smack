//
//  ChannelVC.swift
//  Smack
//
//  Created by MatanHuja on 10/09/2018.
//  Copyright © 2018 Matan Huja. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }


}
