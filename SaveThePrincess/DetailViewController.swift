//
//  DetailViewController.swift
//  SaveThePrincess
//
//  Created by Igor Angelov on 14/08/2017.
//  Copyright © 2017 Igor Angelov. All rights reserved.
//

import UIKit
import CoreData

private let genreCellIdentifier = "GenreCell"
private let addCellIdentifier = "AddCell"
private let showCellIdentifier = "ShowCell"
private let colorCellIdentifier = "ColorCell"

class DetailViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var managedObjectContext: NSManagedObjectContext? = nil
    var mode: String = DetailVCMode.ShowMode // default mode
    var color : UIColor = UIColor.gray
    var gender : String = Gender.male
    
    var detailItem: Soldier? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    let placeholderTextField : Array = ["Name","Color","Genre","Age"] // dynamic textfield
    
    func configureView() {
        // Update the user interface for the detail item.
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        
        // Navigation button set
        if mode == DetailVCMode.AddMode {
            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveCurrentSoldier))
            navigationItem.rightBarButtonItem = saveButton
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Data Save
    func saveCurrentSoldier () {

        let context = fetchedResultsController.managedObjectContext
        let newSoldier = Soldier(context: context)
        newSoldier.name = getContentTextField(IndexPath(row: 0, section: 0))
        newSoldier.color = color.encode() as NSData
        newSoldier.gender = gender
        let age: String = (getContentTextField(IndexPath(row: 3, section: 0)))
        newSoldier.age = Int32(age) ?? 0
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.saveContext()
        
        //back to root view controller
        _ = navigationController?.popToRootViewController(animated: true)

    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeholderTextField.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: configureCellIdentifier(indexPath), for: indexPath)
        configureCell(cell, At: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, At indexPath: IndexPath) {
        if(mode == DetailVCMode.ShowMode) {
            var displayedValue : String =  "\(placeholderTextField[indexPath.row]) : "
            cell.textLabel?.textColor = UIColor.black // default text color
            
            if(indexPath.row == 0) {
                displayedValue += (detailItem?.name)!
            }
            if(indexPath.row == 1) {
                displayedValue = "Soldier \(placeholderTextField[indexPath.row])"
                if let data = detailItem?.color {
                    let newColor = UIColor.color(withData: data as Data)
                    cell.textLabel?.textColor = newColor
                }

            }
            if(indexPath.row == 2) {
                displayedValue += (detailItem?.gender)!
            }
            if(indexPath.row == 3) {
                let age = detailItem?.age ?? 0
                displayedValue += "\(String(describing: age))"
            }
            cell.textLabel?.text = displayedValue
            
        }
        
        if(mode == DetailVCMode.AddMode) {
            // other cell used for index 2
            if(indexPath.row == 1) {
                let colorCell: ColorCell = cell as! ColorCell
                colorCell.setColor()
                colorCell.delegate = self
            }else if (indexPath.row == 2){
                let genreCell:  GenreCell = cell as! GenreCell
                genreCell.delegate = self
            }else {
                let addCell:  AddCell = cell as! AddCell
                addCell.textField.placeholder = placeholderTextField[indexPath.row]
                addCell.textField.spellCheckingType = .no
                addCell.textField.autocorrectionType = .no
                if(indexPath.row == 3) {
                    addCell.textField.keyboardType = .numbersAndPunctuation
                }
                addCell.delegate = self
            }
            
        }

    }

    func getContentTextField (_ indexPath:IndexPath) -> String {
        let cell:  AddCell = tableView.cellForRow(at: indexPath) as! AddCell
        return cell.textField.text!
    }
    
    func configureCellIdentifier(_ indexPath:IndexPath) -> String {
        if(mode == DetailVCMode.AddMode) {
            if(indexPath.row == 1) {
                return colorCellIdentifier
            }else if(indexPath.row == 2) {
                return genreCellIdentifier
            }else {
                return addCellIdentifier
            }
        }
        return showCellIdentifier
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<Soldier> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Soldier> = Soldier.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    var _fetchedResultsController: NSFetchedResultsController<Soldier>? = nil
    
}

extension DetailViewController : AddCellDelegate {
    
    func colorSelected(_ color: UIColor) {
        self.color = color
    }
    
    func genreSelected(_ genre: String) {
        self.gender = genre
    }
    
}
