//
//  DeliveryListViewController.swift
//  DeliveryApp
//
//  Created by Arun Jose on 21/09/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class DeliveryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var deliveryListTableView:UITableView = UITableView()
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var viewModel:DeliveryListViewModel = DeliveryListViewModelViewFromDeliverDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Setup Methods
    func setupView(){
        self.view.backgroundColor = UIColor.blue
        
        self.navigationItem.title = DeliveryListConstant.Title
        let refreshButton = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refresh(sender:)))
        self.navigationItem.setRightBarButton(refreshButton, animated: false)
        
        self.view.addSubview(deliveryListTableView)
        deliveryListTableView.snp.makeConstraints{(make) -> () in
            make.edges.equalTo(self.view.safeAreaLayoutGuide).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) )
        }
        deliveryListTableView.dataSource = self
        deliveryListTableView.delegate = self
        deliveryListTableView.register(DeliveryListCell.self, forCellReuseIdentifier: DeliveryListConstant.Cell.Identifier)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints{(make) -> () in
            make.center.equalTo(deliveryListTableView)
        }
        activityIndicator.isHidden = true
    }
    
    func setupViewModel(){
        viewModel.noOfDeliveries.bind{[unowned self] _ in
            DispatchQueue.main.async {
                self.deliveryListTableView.reloadData()
            }
        }
        viewModel.isDeliveryDataLoading.bind{[unowned self] show in
            if show{
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }else{
                DispatchQueue.main.async {
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        viewModel.error.bind{[unowned self] errorMessage in
            let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
        }
        viewModel.fetchDeliveryList()
    }
    
    @objc func refresh(sender:UIBarButtonItem) {
        viewModel.refreshDeliveryList()
    }
    
    //MARK: Tableview Delegates/DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noOfDeliveries.value
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryListConstant.Cell.Identifier, for: indexPath) as! DeliveryListCell
        
        let deliveryDetail = viewModel.getCellDeliverDetail(atIndex: indexPath)
        
        cell.deliveryDescriptionLabel.text = deliveryDetail.description
        cell.deliveryImageView.kf.setImage(with: URL(string: deliveryDetail.imageUrl))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deliveryDetail = viewModel.getSelectedDeliverDetail(atIndex: indexPath)
        let deliveryDetailViewContlr = DeliveryDetailViewController()
        deliveryDetailViewContlr.viewModel = DeliveryDetailViewModelFromDeliverDetail(deliverDetail: deliveryDetail)
        self.navigationController?.pushViewController(deliveryDetailViewContlr, animated: true)
    }
    
    //MARK: ScrollView Delegates
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == deliveryListTableView{
            if (scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height{
                viewModel.fetchMoreDeliveries()
            }
        }
    }
}
