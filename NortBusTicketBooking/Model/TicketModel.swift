//
//  TicketModel.swift
//  NortBusTicketBooking
//
//  Created by Mac on 30.09.2022.
//

import Foundation


struct Day {
    let dayNumber: Int
    let dayName: String
}

struct Ticket {
    static let shared = Ticket()
    
    var ticketDeparture: String?
    var ticketDestination: String?
}
