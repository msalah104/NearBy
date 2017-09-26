//
//  HomeViewController.swift
//  NearBy
//
//  Created by Mohammed Salah on 9/21/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit
import SDWebImage

enum DataStats {
    case ReadyForNewData;
    case RecivingData
}

class HomeViewController: UIViewController {
    
    // UI
    let CELL_ID = "cellID"
    let CELL_HEIGHT = 90.0
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var notficationImage: UIImageView!
    @IBOutlet weak var notficationLable: UILabel!
    @IBOutlet weak var realTimeButton: UIBarButtonItem!
    
    
    // Vars
    var dataStats:DataStats?
    var places:[Place] = [Place]()
    var updateMode:PlacesUpdateType?
    var homePresenter:HomePresenterController = HomePresenterController()
    var hud:YBHud?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateMode = homePresenter.getPlacesUpdateType()
        realTimeButton.title = updateMode?.rawValue
        self.table.dataSource = self
        dataStats = .ReadyForNewData
        places = homePresenter.getCachedPlaces()
        
        // No UI
        if places.count == 0 {
            self.table.isHidden = true
        }
        self.notficationLable.text = ""
        self.notficationImage.image = UIImage()
        
        homePresenter.attachView(self as HomeViewDelegate)
        self.table.register(UINib(nibName: "PlaceTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_ID)
        
        
        //29.928543,30.918783
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didClickRealtime(_ sender: UIBarButtonItem) {
        
        if updateMode == .Realtime {
            updateMode = .SingleTime
        } else {
            updateMode = .Realtime
        }
        
        places = [Place]()
        table.reloadData()
        
        homePresenter.setPlacesUpdateType(updateMode!)
        
        sender.isEnabled = false;
        
        
        realTimeButton.title = updateMode?.rawValue
        
    }
    
    
}


extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: CELL_ID) as! PlaceTableViewCell
        
        let place = places[indexPath.row]
        
        cell.placeTitle.text = place.name
        
        if let text = place.address1 {
            cell.placeAddress1.text = text
        }
        
        if let text = place.address2 {
            cell.placeAddress2.text = text
        }
        
        if let text = place.address3 {
            cell.placeAddress3.text = text
        }
        
        if let text = place.address4 {
            cell.placeAddress4.text = text
        }
        
        if let url = place.imageUrl {
                cell.placeImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
        } else {
            cell.placeImage.image = #imageLiteral(resourceName: "placeholder")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(CELL_HEIGHT)
    }
}


extension HomeViewController:HomeViewDelegate {
    // Loading
    func startLoading(){
        self.realTimeButton?.isEnabled = false
        
        if places.count == 0 {
            hud = YBHud(hudType: .triplePulse)
            hud?.dimAmount = 0.7
            hud?.show(in: self.view, animated: true)
        }
    }
    
    func finishLoading(){
        hud?.dismiss(animated: true)
        self.realTimeButton?.isEnabled = true
    }
    
    // Error
    func someThingWrongHappend(){
        self.table.isHidden = true
        self.notficationImage.image = #imageLiteral(resourceName: "error")
        self.notficationLable.text = "Somthing went wrong!!"
    }
    
    func noNearPlaces(){
        self.table.isHidden = true
        self.notficationImage.image = #imageLiteral(resourceName: "no locations")
        self.notficationLable.text = "No data found!!"
    }
    
    func locationError(){
        
    }
    
    // UpdateData
    func updatePlaces(_ places:[Place]) {
        self.table.isHidden = false
        self.places = places
        self.table.reloadData()
        dataStats = DataStats.RecivingData
    }
    
    func insertPlace(_ place:Place) {
        
        if dataStats == .ReadyForNewData{
            places = [Place]()
            self.table.reloadData()
            dataStats = DataStats.RecivingData
        }
        
        self.table.isHidden = false
        print("Table insert Place")
        self.places.append(place)
        table.insertRows(at: [IndexPath.init(row: places.count - 1 , section: 0)] , with: .left)
    }
    
    func readyToReciveData(){
        dataStats = DataStats.ReadyForNewData
    }
    
    func requestFinished() {
        homePresenter.cachCurrentRequest(self.places)
    }
}
