//
//  AssetListTableViewController.swift
//  CustomControlsSampleApp
//
//  Copyright © 2018 Ooyala. All rights reserved.
//

import UIKit

class AssetListTableViewController: UITableViewController {
  
  private let PLAYER_SEGUE_IDENTIFIER = "PlayerViewControllerSegue"
  private let CELL_REUSE_IDENTIFIER = "OptionCellReuseIdentifier"
  private let options = OptionDataSource.options()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.tableFooterView = UIView()
    tableView.bounces = false
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }

  // MARK: - UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CELL_REUSE_IDENTIFIER,
                                             for: indexPath)
    cell.textLabel?.text = options[indexPath.row].title
    return cell
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // When tapping on a cell, we'll transition to the PlayerViewController.
    // If that's the case set the PlayerSelectionOption for the player.
    if let indexPath = tableView.indexPathForSelectedRow,
      segue.identifier == PLAYER_SEGUE_IDENTIFIER {
      let playerViewController = segue.destination as! PlayerViewController
      playerViewController.option = options[indexPath.row]
    }
  }
  
}
