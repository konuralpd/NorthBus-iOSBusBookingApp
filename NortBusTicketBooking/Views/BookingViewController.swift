//
//  ViewController.swift
//  NortBusTicketBooking
//
//  Created by Mac on 29.09.2022.
//

import UIKit
import MapKit
import ProgressHUD

class BookingViewController: UIViewController, MKLocalSearchCompleterDelegate {

    @IBOutlet weak var departSearch: UISearchBar!
    @IBOutlet weak var goingSearchBar: UISearchBar!
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var locationTableView: UITableView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var totalPassangerLabel: UILabel!
    var searchBarIndex = 0
    var mapKitSearch = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapKitSearch.delegate = self
        departSearch.delegate = self
        goingSearchBar.delegate = self
        locationTableView.delegate = self
        locationTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationTableView.isHidden = true
        menuView.isHidden = true
        blurView.isHidden = true
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        locationTableView.reloadData()
    }
    
  
    @IBAction func minusButtonClicked(_ sender: Any) {
        if Int(totalPassangerLabel.text!)! > 1 {
            let newPassangerCount = Int(totalPassangerLabel.text!)! - 1
            totalPassangerLabel.text = "\(newPassangerCount)"
        }
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        let newPassangerCount = Int(totalPassangerLabel.text!)! + 1
        totalPassangerLabel.text = "\(newPassangerCount)"
    }
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        menuView.isHidden = false
        blurView.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func menuExitButtonClicked(_ sender: Any) {
        menuView.isHidden = true
        blurView.isHidden = true
        self.navigationController?.isNavigationBarHidden = false
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    @IBAction func findTicketsButtonClicked(_ sender: Any) {
        let ticketVC = storyboard?.instantiateViewController(withIdentifier: "ticketsVC") as! TicketsViewController
        
        let departure = departSearch.text!.components(separatedBy: ", ")
        let arrive = goingSearchBar.text!.components(separatedBy: ", ")
        ticketVC.departureLocation = departure[0]
        ticketVC.arriveLocation = arrive[0]
        ticketVC.modalPresentationStyle = .fullScreen
        if departSearch.text == "" || goingSearchBar.text == "" {
            ProgressHUD.showFailed("Please be sure you make the city selections completely.")
        } else {
            self.navigationController?.pushViewController(ticketVC, animated: true)
        }
    }
    
    
}

extension BookingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        locationTableView.isHidden = false
        mapKitSearch.queryFragment = searchText
        
        searchBarIndex = searchBar.tag
    }
    
    func searchBarTextDidBeginEditing(_searchBar: UISearchBar) {

      }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
               searchBar.setShowsCancelButton(false, animated: true)

               searchBar.endEditing(true)
    }
}

extension BookingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.textLabel?.text = searchResult.title
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResult = searchResults[indexPath.row]
        if searchBarIndex == 0 {
            departSearch.text = searchResult.title
        }
        
        if searchBarIndex == 1 {
            goingSearchBar.text = searchResult.title
        }

        tableView.deselectRow(at: indexPath, animated: true)
        
        searchResults.removeAll()
        locationTableView.reloadData()
        locationTableView.isHidden = true
        
    }
    

    
}
