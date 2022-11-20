//
//  PushNotificationViewModel.swift
//  DemoDiffableTableView
//
//  Created by Sally Xie on 2022/11/20.
//

import Foundation

protocol PushNotificationViewModelDelegate: AnyObject {
    func fetchDataSuccess()
}

class PushNotificationViewModel {
    /// [時間：[推播訊息]]
    private var notificationDic: [String: [NotificationInfo]] = [:]
    
    private var fakeNotifications = [NotificationInfo(date: "2022/11/11", content: "裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔"), NotificationInfo(date: "2022/11/12", content: "裝置管理喔"), NotificationInfo(date: "2022/11/13", content: "裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔")]
    
    private var willPushNotifications = [NotificationInfo(date: "2022/11/12", content: "裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔"), NotificationInfo(date: "2022/11/14", content: "裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔裝置管理喔"), NotificationInfo(date: "2022/11/15", content: "裝置管理喔裝置管理喔裝置管理喔")]
    
    weak var delegate: PushNotificationViewModelDelegate? = nil
    
    func fetchData() {
        
        setDataToDic(models: fakeNotifications)
        
        delegate?.fetchDataSuccess()
        
    }

    func setDataToDic(models: [NotificationInfo]) {
        for item in models {
            guard var value = notificationDic[item.date] else {
                notificationDic[item.date] = [item]
                continue
            }
            
            value.append(item)
            notificationDic[item.date] = value
        }
    }
    
    func getModels(at key: String) -> [NotificationInfo]? {
        return notificationDic[key]
    }
    
    func getSections() -> [String] {
        let sections = notificationDic.keys.map {$0}
        return sections.sorted().reversed()
    }
    
    func addNotification() {
        if let model = willPushNotifications.first {
            setDataToDic(models: [model])
            willPushNotifications.remove(at: 0)
        }


        delegate?.fetchDataSuccess()
    }
    
    func removeNotification() {
        
        if let key = notificationDic.keys.first {
            notificationDic.removeValue(forKey: key)
        }
        
        delegate?.fetchDataSuccess()
    }
}
