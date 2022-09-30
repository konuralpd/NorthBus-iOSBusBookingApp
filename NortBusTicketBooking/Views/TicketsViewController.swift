//
//  TicketsViewController.swift
//  NortBusTicketBooking
//
//  Created by Mac on 29.09.2022.
//

import UIKit

class TicketsViewController: UIViewController {

    @IBOutlet weak var ticketsCollectionView: UICollectionView!
    
    @IBOutlet weak var ticketsTableView: UITableView!
    
    
    var days = [Day]()
    var departureLocation: String = ""
    var arriveLocation: String = ""
    var ticket = Ticket.shared
    var index = 2
    override func viewDidLoad() {
        super.viewDidLoad()

        ticketsCollectionView.delegate = self
        ticketsCollectionView.dataSource = self
        
        let d1 = Day(dayNumber: 28, dayName: "SUN")
        let d2 = Day(dayNumber: 29, dayName: "MON")
        let d3 = Day(dayNumber: 30, dayName: "TUE")
        let d4 = Day(dayNumber: 1, dayName: "WED")
        let d5 = Day(dayNumber: 2, dayName: "THU")
        let d6 = Day(dayNumber: 3, dayName: "FRI")
        let d7 = Day(dayNumber: 4, dayName: "SAT")
        
        days.append(d1)
        days.append(d2)
        days.append(d3)
        days.append(d4)
        days.append(d5)
        days.append(d6)
        days.append(d7)
        
        designCollectionViews()
        
    }
   

    func designCollectionViews() {
        let design = UICollectionViewFlowLayout()
        design.scrollDirection = .horizontal
        design.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        design.minimumLineSpacing = 10
        design.minimumLineSpacing = 10
        
        let width = ticketsCollectionView.frame.size.width
        let cellWidth = (width-30)/4
        design.itemSize = CGSize(width: cellWidth, height: cellWidth)
        ticketsCollectionView.collectionViewLayout = design
        
        ticketsTableView.delegate = self
        ticketsTableView.dataSource = self
    }

}


extension TicketsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let day = days[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daysCell", for: indexPath) as! DaysCollectionViewCell
        cell.layer.cornerRadius = 9
        cell.dayNameLabel.text = day.dayName
        cell.dayNumberLabel.text = "\(day.dayNumber)"
        if indexPath.row == index {
            cell.dayBgView.backgroundColor = .systemCyan
            cell.dayNumberLabel.textColor = .white
            cell.dayNameLabel.textColor = .white
        } else {
            cell.dayBgView.backgroundColor = .white
            cell.dayNumberLabel.textColor = .systemGray
            cell.dayNameLabel.textColor = .systemGray
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        collectionView.reloadData()
    }

    
    
}

extension TicketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ticketsCell", for: indexPath) as! TicketsTableViewCell
        cell.destinationLabel.text = departureLocation
        cell.departureLabel.text = departureLocation
        cell.arriveLabel.text = arriveLocation
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSeatSelect", sender: nil)
    }
    
    
}
