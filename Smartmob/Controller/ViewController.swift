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
    var searchBar: UISearchBar!
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
        self.navigationItem.title = "Item"
        getTopTenData()
        rightBarButtonVisible()
        // Do any additional setup after loading the view.
    }
    
    func getTopTenData(){
        APIHandler.getTopImages(viewController: self) { [weak self](response) in
            guard let strongSelf = self else {return}
            strongSelf.imagesListDataSource = response?.images
            strongSelf.imageListFilterData = response?.images
            strongSelf.listTableView.reloadData()
        }
    }
    func getSearchData(_ searchItems: String){
        APIHandler.searchImages(searchItem: searchItems, viewController: self) { [weak self](response) in
            guard let strongSelf = self else {return}
            if strongSelf.searchBar.text != "" {
                strongSelf.imageListFilterData = response?.images
                strongSelf.listTableView.reloadData()
            }
        }
    }
    
    @objc func searchButtonClicked() {
        searchBar = UISearchBar()
        self.navigationItem.titleView = searchBar
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.placeholder = "Search Items Here eg.Laptop"
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = imageListFilterData?[indexPath.row]
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = story.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
        viewController.imageUrl = data?.url
        self.navigationController?.pushViewController(viewController, animated: true)
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
        if searchText == "" || searchText.isEmpty {
            self.imageListFilterData = self.imagesListDataSource
        } else {
            getSearchData(searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.isHidden = true
        rightBarButtonVisible()
        self.imageListFilterData = self.imagesListDataSource
        // and clear the text in the search bar
        // You could also change the position, frame etc of the searchBar
    }
}
