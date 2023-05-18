//
//  ViewController.swift
//  SportsApp
//
//  Created by Rafeef Esam on 05/05/2023.
//

import UIKit

class SportsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
 
    @IBOutlet weak var sportsCollectionView: UICollectionView!
    
    var sportsArray : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sportsArray = ["FootBall", "BasketBall", "Cricket", "Tennis"]
        print(sportsCollectionView.bounds.width)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width * 0.60 , height: self.view.frame.width * 0.50)

        sportsCollectionView.collectionViewLayout = layout
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.459, height: self.view.frame.width * 0.60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SportsCollectionCell
        cell?.SportsCollectionImg.image = UIImage(named: sportsArray![indexPath.row])
        cell?.SportsCollectionName.text = sportsArray![indexPath.row]
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !InternetCheker.isInternetAvailable(){
            showNoInternetAlert()
        }else{
            let leagueTVC = self.storyboard?.instantiateViewController(withIdentifier: "leagueTVC") as! LeagueTableViewController
            leagueTVC.sportName = sportsArray![indexPath.row].lowercased()
               self.navigationController?.pushViewController(leagueTVC, animated: true)
        }
      
    }

}

