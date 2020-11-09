//
//  ViewController.swift
//  waterFallLayout
//
//  Created by MAC on 07/11/20.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var desArray = ["Lorem Ipsum is remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.","The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book.","Sed lacus velit, auctor id enim at, facilisis iaculis nisi. Sed iaculis dolor vestibulum augue consectetur accumsan.Cras quis metus sit amet lorem rhoncus tincidunt eget id nulla. Fusce fringilla ex tortor, et ullamcorper risus viverra sed. Etiam a dictum eros. In hac habitasse platea dictumst.","Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.","It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages","dummy text used in laying out print dummy text used in laying out printdummy text used in laying out printdummy text used in laying out printdummy text used in laying out printdummy out printdummy text used in laying out printdummy text used in laying out printdummy text used in laying out printdummy text used in laying out printdummy text used in laying out printdummy text used in laying out printdummy text used in" , "laying out printdummy text used in laying out printdummy" , "text used in laying out printdummy text used in laying out printused inlaying out printused in laying out print"]
    
   
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        if let layout = collectionView.collectionViewLayout as? LiquidCollectionViewLayout{
            layout.delegate = self
        }
    }
}



extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return desArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.lblText.text = desArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let c = desArray[indexPath.row].count
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(c+200))
    }
}

extension ViewController:LiquidLayoutDelegate{
    func collectionView(collectionView: UICollectionView, heightForCellAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat {
        let caption = desArray[indexPath.row].count
        return CGFloat(caption)
    }
}
