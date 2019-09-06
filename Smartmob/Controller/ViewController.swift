//
//  ViewController.swift
//  Smartmob
//
//  Created by Amresh Subedi on 9/6/19.
//  Copyright © 2019 Amresh. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    var imagesListDataSource: [Images]?
    var imageListFilterData: [Images]?{
        didSet{
            self.listTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        getTopTenData()
        rightBarButtonVisible()
        // Do any additional setup after loading the view.
    }

    func getTopTenData(){
        APIHandler.getTopImages(viewController: self) { (response) in
            self.imagesListDataSource = response?.images
            self.imageListFilterData = response?.images
        }
    }
    @objc func searchButtonClicked() {
        let searchBar = UISearchBar()
        self.navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        self.navigationItem.rightBarButtonItem = nil
    }
    func rightBarButtonVisible() {
        let testUIBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconSearch"), style: .plain, target: self, action: #selector(self.searchButtonClicked))
        testUIBarButtonItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageListFilterData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = imageListFilterData?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ImageListTableViewCell
        if let url = URL(string: data?.url ?? "") {
            cell.listImageView.af_setImage(withURL: url)
        }
        cell.listImageView.layer.cornerRadius = 15
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Do some search stuff
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        // You could also change the position, frame etc of the searchBar
    }
}
