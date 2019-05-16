//
//  StateDetailTableViewController.swift
//  Representative
//
//  Created by Dustin Koch on 5/16/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class StateDetailTableViewController: UITableViewController {
    
    //MARK: - Properties
    var state: String?
    var representatives: [Representative] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let state = state else { return }
        RepresentativeController.shared.fetchRepresentativesFor(state: state) { (representatives) in
            self.representatives = representatives
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let stateString = state else { return "" }
        return "State representatives for \(stateString)"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representatives.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "representativeCell", for: indexPath) as? RepresentativeTableViewCell else { return UITableViewCell() }
        let rep = representatives[indexPath.row]
        cell.nameLabel.text = rep.name
        cell.districtLabel.text = "District: \(rep.district)"
        cell.phoneLabel.text = rep.phone
        return cell
    }

}
