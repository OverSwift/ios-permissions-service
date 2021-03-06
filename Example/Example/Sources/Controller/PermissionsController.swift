//
//  PrmissionsController.swift
//  PermissionsService
//
//  Created by Yuriy Trach on 10/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import PermissionsService

extension PermissionsController: ServiceDisplay {}

class PermissionsController: UITableViewController {
	
	enum CellsIndexes: Int
	{
		case gallery = 0
		case calendar
		case camera
    case location
    case contacts
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
		guard let cellIndex = CellsIndexes(rawValue: indexPath.row) else {
			assertionFailure("guarrd in \(#file) on \(#line) line")
			return
		}
		
		var instanceName = ""
		
		let block = { [unowned self] (granted: Bool) in
			var title: String!
			var message: String!
			if granted {
				title = "Success"
				message = "Permision for \(instanceName) is granded"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
			}
		}
		
		switch cellIndex {
		case .gallery:
      instanceName = "Gallery"
  		Permission<GalleryPermission>.prepare(for: self, callback: block)
		case .calendar:
      instanceName = "Calendat"
      Permission<CalendarPermission>.prepare(for: self, callback: block)
		case .camera:
      instanceName = "Camera"
      Permission<CameraPermissions>.prepare(for: self, callback: block)
    case .location:
      instanceName = "Location"
      Permission<LocationPermission>.prepare(for: self, callback: block)
    case .contacts:
      instanceName = "Contacts"
      Permission<ContactsPermission>.prepare(for: self, callback: block)
		}
	}
	
}
