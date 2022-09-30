//
//  SelectSeatViewController.swift
//  NortBusTicketBooking
//
//  Created by Mac on 30.09.2022.
//

import UIKit

class SelectSeatViewController: UIViewController {

    @IBOutlet weak var leftSeatsCollectionView: UICollectionView!
    
    @IBOutlet weak var rightSeatsCollectionView: UICollectionView!
    
    
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leftSeatsCollectionView.delegate = self
        leftSeatsCollectionView.dataSource = self
        rightSeatsCollectionView.delegate = self
        rightSeatsCollectionView.dataSource = self
        
        designCollectionViews()
        
       
    }
    
    func designCollectionViews() {
        let design = UICollectionViewFlowLayout()
        design.scrollDirection = .vertical
        design.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        design.minimumLineSpacing = 10
        design.minimumLineSpacing = 10
        
        let design2 = UICollectionViewFlowLayout()
        design2.scrollDirection = .vertical
        design2.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        design2.minimumLineSpacing = 10
        design2.minimumLineSpacing = 10
        
        let width = rightSeatsCollectionView.frame.size.width
        let cellWidth = (width-30)/2
        design.itemSize = CGSize(width: cellWidth, height: cellWidth)
        rightSeatsCollectionView.collectionViewLayout = design
        
        let width2 = leftSeatsCollectionView.frame.size.width
        design2.itemSize = CGSize(width: cellWidth, height: cellWidth)
        leftSeatsCollectionView.collectionViewLayout = design2
    }
    
    

}


extension SelectSeatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case leftSeatsCollectionView:
            return 10
        case rightSeatsCollectionView:
            return 30
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case leftSeatsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leftSeatCell", for: indexPath) as! LeftSeatCollectionViewCell
            cell.seatNumberLabel.text = "\(indexPath.row)"
            if indexPath.row == index {
                cell.bgView.backgroundColor = UIColor.systemCyan
            } else {
                cell.bgView.backgroundColor = .white
            }
            return cell
        case rightSeatsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rightSeatCell", for: indexPath) as! RightSeatsCollectionViewCell
            cell.seatNumberLabel.text = "\(indexPath.row + 10)"
            if indexPath.row == index {
                cell.bgView.backgroundColor = UIColor.systemCyan
            } else {
                cell.bgView.backgroundColor = .white
            }
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        collectionView.reloadData()
    }

}
