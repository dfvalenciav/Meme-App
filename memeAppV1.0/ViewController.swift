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
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolBarBottom: UIToolbar!
    @IBOutlet weak var toolBarTop: UIToolbar!
    
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
        shareButton.isEnabled = false
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pickerCamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {

        view.frame.origin.y -= getKeyboardHeight(notification)
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {

        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }


    @IBAction func pickerGalleryAction(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = .photoLibrary
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        shareButton.isEnabled = true
    }
    
    
    @IBAction func pickerCameraAction(_ sender: Any) {
        let pickerController1 = UIImagePickerController()
        pickerController1.sourceType = .camera
        pickerController1.delegate = self
        present(pickerController1, animated: true, completion: nil)
        shareButton.isEnabled = true
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let shareImage = generateMemedImage()
        let nextController = UIActivityViewController (activityItems : [shareImage],applicationActivities : nil)
        self.present (nextController, animated: true, completion: nil)
        nextController.completionWithItemsHandler = {
            (activity, success, items, error) in self.save()
        }
    }
    
    func save () {
        let topTextFieldString : String = topTextField.text!
        let bottomTextFieldString : String = bottomTextField.text!
        let meme = Meme(
            topText:topTextFieldString,
            bottomText: bottomTextFieldString,
            originalImage: self.memeImage.image!, memedImage: generateMemedImage())
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            memeImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func generateMemedImage() -> UIImage {
        // hidden toolbar and navbar before render
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        toolBarTop.isHidden = true
        toolBarBottom.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // showing toolbar and navbar after render
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        toolBarTop.isHidden = false
        toolBarBottom.isHidden = false
        return memedImage
    }
    

    
}


