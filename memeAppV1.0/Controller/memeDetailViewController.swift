//
//  memeDetailViewController.swift
//  memeAppV1.0
//
//  Created by Daniel Felipe Valencia Rodriguez on 5/04/22.
//

import UIKit

class memeDetailViewController: UIViewController {

    @IBOutlet weak var memeImageDetail: UIImageView!
    var meme : Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeImageDetail.image = meme.memedImage

    }
    
}
