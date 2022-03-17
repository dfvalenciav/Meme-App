//
//  ViewController.swift
//  memeAppV1.0
//
//  Created by Daniel Felipe Valencia Rodriguez on 15/03/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerCamera: UIBarButtonItem!
    @IBOutlet weak var pickerGallery: UIBarButtonItem!
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pickerCameraAction(_ sender: Any) {
       
    }
    
    @IBAction func pickerGalleryAction(_ sender: Any) {
        let pickerController = UIImagePickerController()
        present(pickerController, animated: true, completion: nil)
    }
}

