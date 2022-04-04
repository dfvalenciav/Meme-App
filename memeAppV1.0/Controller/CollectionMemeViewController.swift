//
//  CollectionMemeViewController.swift
//  memeAppV1.0
//
//  Created by Daniel Felipe Valencia Rodriguez on 4/04/22.
//

import UIKit

class CollectionMemeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

        @IBOutlet weak var collectionViewOutlet: UICollectionView!

        var memes : [Meme]! {
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            return appDelegate.memes
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            collectionViewOutlet.delegate = self
            collectionViewOutlet.dataSource = self
        }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            collectionViewOutlet.reloadData()
        }
        
        @IBAction func plusButtonAction(_ sender: Any) {
            let memeEditorViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
            present(memeEditorViewController, animated: true, completion: nil)
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.memes.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCell", for: indexPath) as? memeCollectionViewCell
            let meme = self.memes[(indexPath as NSIndexPath).row]
            cell!.memeImageView.image = meme.memedImage
            return cell!
        }
}
