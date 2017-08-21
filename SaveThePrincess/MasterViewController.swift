//
//  MasterViewController.swift
//  SaveThePrincess
//
//  Created by Igor Angelov on 14/08/2017.
//  Copyright © 2017 Igor Angelov. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "SoldierCell"
private let footerReuseIdentifier = "Footer"

class MasterViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {
    
    var managedObjectContext: NSManagedObjectContext? = nil
    var storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Base"
        
        // Navigation button set
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewSoldier(_:)))
        navigationItem.rightBarButtonItem = addButton
        
        // Core data context set
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNewSoldier(_ sender: Any) {
        let vc = self.storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.managedObjectContext = self.managedObjectContext
        vc.mode = DetailVCMode.AddMode
        vc.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let event = fetchedResultsController.object(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SoldierCell
        cell.soldier = event
        cell.delegate = self
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerReuseIdentifier, for: indexPath)
            return footer
            
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object = fetchedResultsController.object(at: indexPath)
        let vc = self.storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.managedObjectContext = self.managedObjectContext
        vc.mode = DetailVCMode.ShowMode
        vc.detailItem = object
        vc.navigationItem.leftItemsSupplementBackButton = true
        self.navigationController?.pushViewController(vc, animated: true)
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
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController<Soldier>? = nil
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView?.reloadData()
    }
    
}

extension MasterViewController : SoldierCellDelegate {
    
    func soldierAttack(_ soldier:Soldier){
        let damage : Int32 = soldier.age
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.wall?.durability = (appDelegate.wall?.durability)! - damage
        
        if((appDelegate.wall?.durability)! < 0) {
            //save the princess
            if let index = collectionView?.indexPathsForVisibleSupplementaryElements(ofKind: UICollectionElementKindSectionFooter)[0] {
                let footer : WallFooter = collectionView?.supplementaryView(forElementKind: UICollectionElementKindSectionFooter, at: index) as! WallFooter
                //change soldier color - default grey color
                var newColor = UIColor.gray
                if let data = soldier.color {
                    newColor = UIColor.color(withData: data as Data)
                }
                footer.princessSaved(newColor)
            }

        }// do random if princess are not saved 
        else {
            let rand = arc4random_uniform(1) + UInt32(damage);

            //Array shuffle
            let context = fetchedResultsController.managedObjectContext
            var myList = fetchedResultsController.fetchedObjects
            myList?.shuffle()
            
            //kill soldier, for taked domage o
            var count  = 1
            let randInt = Int(rand)
            for object in myList! {
                if(count >= randInt) {
                    break
                }
                context.delete(object)
                count = count + 1
            }
            
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }

        }
        
        

    }

}
