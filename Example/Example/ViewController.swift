//
//  ViewController.swift
//  Example
//
//  Created by Philippe Asselbergh on 04/10/2017.
//  Copyright © 2017 Philippe Asselbergh. All rights reserved.
//
import UIKit
import CircularCollectionView

class ViewController: UIViewController {
    
    @IBOutlet weak var circularCollection: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wheelLbl: UILabel!
    var prevID: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        circularCollection.delegate = self
        circularCollection.dataSource = self
        selectProfile(id: 0)
        self.imageView.contentMode = .scaleToFill
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: UICollectionViewDataSource
    
    func selectProfile(id: Int){
        DispatchQueue.main.async() {
            UIView.transition(with: self.imageView,
                              duration: 1,
                              options: .transitionCrossDissolve,
                              animations: { self.imageView.image = UIImage(named: Constants.images[id]) },
                              completion: nil)
        }
        
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.contentOffset = CGPoint(x: Int(150/2)*(indexPath.row), y:0)
        if prevID != indexPath.row{
            self.selectProfile(id: indexPath.row)
            prevID = indexPath.row
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        print(round((scrollView.contentOffset.x/75)))
        if prevID != Int(round((scrollView.contentOffset.x/75))){
            if Int(round((scrollView.contentOffset.x/75))) < 0{
                self.selectProfile(id: 0)
            }else if Int(round((scrollView.contentOffset.x/75))) > Constants.images.count-1{
                self.selectProfile(id: Constants.images.count-1)
            }else{
                self.selectProfile(id: Int(round((scrollView.contentOffset.x/75))))
            }
            prevID = Int(round((scrollView.contentOffset.x/75)))
        }
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(round((scrollView.contentOffset.x/75)))
        if prevID != Int(round((scrollView.contentOffset.x/75))){
            if Int(round((scrollView.contentOffset.x/75))) < 0{
                self.selectProfile(id: 0)
            }else if Int(round((scrollView.contentOffset.x/75))) > Constants.images.count-1{
                self.selectProfile(id: Constants.images.count-1)
            }else{
                self.selectProfile(id: Int(round((scrollView.contentOffset.x/75))))
            }
            prevID = Int(round((scrollView.contentOffset.x/75)))
       }
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CircularCollectionViewCell", for: indexPath) as! CircularCollectionViewCell
        DispatchQueue.main.async {
            let imageView = UIImageView(frame: CGRect(x: 25, y: 0, width: 100, height: 100))
            imageView.image = UIImage(named: Constants.images[indexPath.row])
            imageView.contentMode = .scaleToFill
            imageView.layer.cornerRadius = imageView.frame.size.width/2
            imageView.clipsToBounds = true
            imageView.layer.borderWidth = 1.0
            imageView.layer.borderColor = UIColor.white.cgColor
            cell.addSubview(imageView)
//            cell.layer.borderColor = UIColor.black.cgColor
//            cell.layer.borderWidth = 1
        }
        return cell
        
    }
}
