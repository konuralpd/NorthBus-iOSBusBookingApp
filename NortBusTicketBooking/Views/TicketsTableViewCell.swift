//
//  TicketsTableViewCell.swift
//  NortBusTicketBooking
//
//  Created by Mac on 30.09.2022.
//

import UIKit

class TicketsTableViewCell: UITableViewCell {

    @IBOutlet weak var destinationLabel: UILabel!
    
    @IBOutlet weak var departureLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var arriveLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
