//
//  ViewController.swift
//  memeAppV1.0
//
//  Created by Daniel Felipe Valencia Rodriguez on 15/03/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    //MARK - MULTIMEDIA OBJECTCS
    @IBOutlet weak var pickerCamera: UIBarButtonItem!
    @IBOutlet weak var pickerGallery: UIBarButtonItem!
    @IBOutlet weak var memeImage: UIImageView!
    
    //MARK - TEXTFIELD OBJECTS
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: -3.0,
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pickerCamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }


    @IBAction func pickerGalleryAction(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func pickerCameraAction(_ sender: Any) {
        let pickerController1 = UIImagePickerController()
        pickerController1.sourceType = .camera
        pickerController1.delegate = self
        present(pickerController1, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            memeImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
}

