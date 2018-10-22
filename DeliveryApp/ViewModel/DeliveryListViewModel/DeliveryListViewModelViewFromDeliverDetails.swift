//
//  DeliveryListViewModelFromDeliverDetails.swift
//  DeliveryApp
//
//  Created by Arun Jose on 20/10/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation
import Reachability

class DeliveryListViewModelViewFromDeliverDetails: NSObject, DeliveryListViewModel {
    private var apiService = URLSessionAPIService()
    private var deliveryList:[DeliveryDetail] = []
    private var deliveryListDataSource:[DeliveryDetailCellSource] = []
    private let jsonArchiveCahce = JSONArchiveCache()
    private var deliveryListApiOffset = 1
    private var deliveryListApiLimit = 20
    
    var isOffline: Dynamic<Bool>
    var noOfDeliveries:Dynamic<Int>
    var isDeliveryDataLoading:Dynamic<Bool>
    var error: Dynamic<String>
    
    override init() {
        isOffline = Dynamic(false)
        isDeliveryDataLoading = Dynamic(false)
        noOfDeliveries = Dynamic(0)
        error = Dynamic("")
        super.init()
    }
    
    func getCellDeliverDetail(atIndex indexpath:IndexPath) -> DeliveryDetailCellSource{
        return deliveryListDataSource[indexpath.row]
    }
    
    func getSelectedDeliverDetail(atIndex indexpath:IndexPath) -> DeliveryDetail{
        return deliveryList[indexpath.row]
    }
    
    func fetchMoreDeliveries(){
        if !isDeliveryDataLoading.value {
            self.deliveryListApiOffset += 20
            self.deliveryListApiLimit += 20
            fetchDeliveryList()
        }
    }
    
    func fetchDeliveryList() {
        if ((Reachability()!.connection) == .none && deliveryList.count == 0) {
            self.fetchDeliveryListFromCache()
            return
        }
        self.isDeliveryDataLoading.value = true
        apiService.dispatch(apiRequest: DeliveryRequestsEndPoint.deliveryList(offset: deliveryListApiOffset, limit: deliveryListApiLimit)) { (data, response, error) in
            if let data = data {
                do {
                    let deliveryList = try JSONDecoder().decode([DeliveryDetail].self, from: data) 
                    self.processFetchedDelieryDetail(deliveryList: deliveryList)
                } catch {
                    print(error)
                    self.error.value = error.localizedDescription
                }
            }
            self.isDeliveryDataLoading.value = false
            if let response = response {
                print(response)
            }
            if let error = error {
                print(error)
                self.error.value = error.localizedDescription
            }
        }
    }
    
    private func processFetchedDelieryDetail(deliveryList:[DeliveryDetail], needCache:Bool = true){
        if deliveryList.count == 0 {
            self.error.value = DeliveryListConstant.ErrorMessages.NoDataToShow
            return
        }
        self.deliveryList.append(contentsOf:deliveryList)
        var cellDataSourceList:[DeliveryDetailCellSource] = []
        for deliveryDetail in deliveryList{
            let cellDataScoure = DeliveryDetailCellSource(imageUrl: deliveryDetail.imageURL ?? "", description: deliveryDetail.deliveryDesc ?? "")
            cellDataSourceList.append(cellDataScoure)
        }
        self.deliveryListDataSource.append(contentsOf:cellDataSourceList)
        self.noOfDeliveries.value = self.deliveryListDataSource.count
        
        if needCache {
            saveDeliveryDetailsToCache()
        }
    }
    
    private func saveDeliveryDetailsToCache(){
        jsonArchiveCahce.fileName = DeliveryListConstant.FileName.DeliverList
        do {
            try jsonArchiveCahce.save(object: self.deliveryList)
        } catch {
            print("cache error: ", error.localizedDescription)
        }
    }
    
    private func fetchDeliveryListFromCache(){
        jsonArchiveCahce.fileName = DeliveryListConstant.FileName.DeliverList
        do {
            let deliveryList = try jsonArchiveCahce.retrive(objectType: [DeliveryDetail].self)
            processFetchedDelieryDetail(deliveryList: deliveryList, needCache:false)
        } catch {
            self.error.value = DeliveryListConstant.ErrorMessages.NoDataToShow
        }
    }
}
