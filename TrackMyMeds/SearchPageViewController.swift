//
//  SearchPageViewController.swift
//  TrackMyMeds
//
//  Created by Nicolas Cruz on 4/6/2017.
//  Copyright © 2017 TecoCraft Troop. All rights reserved.
//

import UIKit
import Alamofire

struct medicineCell {
    let tradename : String!
    let brand : String!
}

class SearchPageViewController: UITableViewController, UISearchBarDelegate {
    
    var medicineCells = [medicineCell]()
    
    @IBOutlet var searchBar: UISearchBar!
    typealias readJSON = [String: AnyObject]

    var urlString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func callAlamo(url: String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            response in
            self.parseData(JSONData: response.data!)
        })
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let keywords = searchBar.text
        let userInput = keywords?.replacingOccurrences(of: " ", with: "+")
        
        let urlString = "https://search-track-my-meds-mngalgujcrzj5y7xwvzumwk2ye.ap-southeast-2.es.amazonaws.com/my_index_v2/medicine/_search?q=\(userInput!)"
        
        print(urlString)
        callAlamo(url: urlString)
        self.view.endEditing(true)
    }
    
    func parseData(JSONData : Data) {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! readJSON
            //print(readableJSON)
            if let hits1 = readableJSON["hits"] as? readJSON{
                if let hits2 = hits1["hits"] as? [readJSON] {
                    
                    for i in 0..<hits2.count{
                        
                        let item = hits2[i]
                        if let source = item["_source"] as? readJSON {
                            
                            let tradename = source["tradename"] as! String
                            let brand = source["brand"] as! String
                            
                            medicineCells.append(medicineCell.init(tradename: tradename, brand: brand))
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
        catch{
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        
        let addMed = segue.destination as! AddMedicineViewController
        
        addMed.seguePerformed = true
        addMed.passName = medicineCells[indexPath!].tradename
        addMed.passBrand = medicineCells[indexPath!].brand
    }
    
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineCells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        /*
        let mainImageView = cell?.viewWithTag(3) as! UIImageView
        mainImageView.image = medicineCells[indexPath.row].mainImage
        */
        
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        mainLabel.text = medicineCells[indexPath.row].tradename
        
        let subLabel = cell?.viewWithTag(2) as! UILabel
        subLabel.text = medicineCells[indexPath.row].brand
        
        return cell!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
/*
class medicineSearch: NSObject {
    static func fetchFeaturedApps(_ completionHandler: @escaping (medicineSearch) -> ()) {
        
        let keywords = searchBar.text
        let userInput = keywords?.replacingOccurrences(of: " ", with: "+")
        
        let urlString = "https://search-track-my-meds-mngalgujcrzj5y7xwvzumwk2ye.ap-southeast-2.es.amazonaws.com/my_index_v2/search?q=\(userInput!)&type=medicine&limit=10"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                
                let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                
                let MedicineSearch = medicineSearch()
                MedicineSearch.setValuesForKeys(json as! [String: AnyObject])
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(MedicineSearch)
                })
                
            } catch let err {
                print(err)
            }
            
        }) .resume()
        
    }
    
}
 */
