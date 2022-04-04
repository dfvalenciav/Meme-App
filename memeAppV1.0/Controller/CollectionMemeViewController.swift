//
//  CollectionMemeViewController.swift
//  memeAppV1.0
//
//  Created by Daniel Felipe Valencia Rodriguez on 4/04/22.
//

import UIKit

class CollectionMemeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        //Outlets
        @IBOutlet weak var collectionViewOutlet: UICollectionView!
        @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //let memeEditorViewController : MemeEditorViewController!
    
        //Meme object
        var memes : [Meme]! {
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            return appDelegate.memes
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            
            //Setting delegates
            collectionViewOutlet.delegate = self
            collectionViewOutlet.dataSource = self
            
            
            //flowlayout
            let space:CGFloat = 3.0
            let dimension = (view.frame.size.width - (2 * space))/3.0
            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = space
            flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            collectionViewOutlet.reloadData()
        }
        
        @IBAction func plusButtonAction(_ sender: Any) {
            let memeEditorViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
            self.navigationController?.pushViewController(memeEditorViewController, animated: true)
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
