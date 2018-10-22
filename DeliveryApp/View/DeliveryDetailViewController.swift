//
//  DeliveryDetailViewController.swift
//  DeliveryApp
//
//  Created by Arun Jose on 22/10/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController, MKMapViewDelegate {

    var mapView = MKMapView()
    var headLineView = UIView()
    var imageView = UIImageView()
    var descriptionLabel = UILabel()
    
    var viewModel:DeliveryDetailViewModel?{
        didSet{
            fillUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fillUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor.blue
        
        self.view.addSubview(headLineView)
        headLineView.snp.makeConstraints{(make) -> () in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-5)
            make.height.equalTo(100)
        }
        self.headLineView.backgroundColor = UIColor.white
        
        self.headLineView.addSubview(imageView)
        imageView.snp.makeConstraints{(make) -> () in
            make.top.equalTo(headLineView).offset(5)
            make.leading.equalTo(headLineView).offset(5)
            make.bottom.equalTo(headLineView).offset(-5)
            make.width.equalTo(imageView.snp.height).multipliedBy(1)
        }
        
        self.headLineView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints{(make) -> () in
            make.top.equalTo(headLineView).offset(5)
            make.leading.equalTo(imageView.snp.trailing).offset(10)
            make.bottom.equalTo(headLineView).offset(-5)
            make.trailing.equalTo(headLineView).offset(-5)
        }
        
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints{(make) -> () in
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-5)
            make.top.equalTo(headLineView.snp.bottom).offset(10)
        }
        
        self.navigationItem.title = DeliveryDetailConstant.Title
        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(popViewController(sender:)))
        self.navigationItem.setLeftBarButton(newBackButton, animated: false)
    }

    func fillUI(){
        if !isViewLoaded{
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        self.imageView.kf.setImage(with:URL(string:viewModel.imageUrl))
        self.descriptionLabel.text = viewModel.deliverDescription
        let mapAnnotation = MKPointAnnotation()
        mapAnnotation.coordinate = viewModel.coordinate
        mapAnnotation.title = viewModel.address
        self.mapView.addAnnotation(mapAnnotation)
        self.mapView.showAnnotations([mapAnnotation], animated: true)
    }
    
    @objc func popViewController(sender:UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
