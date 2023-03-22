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
    /// 排序
    enum Order {
        // 大到小
        case desc
        // 小到大
        case asc
        // 不排序
        case none
    }
    
    /// [時間：[推播訊息]]
    private var notificationDic: [String: [NotificationInfo]] = [:]
    /// 預設初始資料
    private var fakeNotifications = NotificationInfo.fakeNotifications
    /// 預設可新增資料
    private var willPushNotifications = NotificationInfo.willPushNotifications
    /// 全部亂序資料
    private var allShuffledArrayPushNotifications = NotificationInfo.allShuffledArrayPushNotifications
    /// 全部排序過資料
    private var allSortPushNotifications = NotificationInfo.allSortPushNotifications
    
    /// 預設排序大到小
    private var order: Order = .desc
    
    weak var delegate: PushNotificationViewModelDelegate? = nil
    
    /// 抓取假資料
    func fetchData() {
        self.setDataToDic(models: self.fakeNotifications)
        self.delegate?.fetchDataSuccess()
    }
    
    /// 設定資料到字典
    /// - Parameter models: [NotificationInfo]
    func setDataToDic(models: [NotificationInfo]) {
        for item in models {
            guard var value = notificationDic[item.date] else {
                self.notificationDic[item.date] = [item]
                continue
            }
            
            value.append(item)
            self.notificationDic[item.date] = value
        }
    }
    
    /// 取得某section的models
    /// - Parameter key: section
    /// - Returns: [NotificationInfo]
    func getModels(at key: String) -> [NotificationInfo]? {
        return self.notificationDic[key]
    }
    
    /// 取得sections
    /// - Returns: sections data
    func getSections() -> [String] {
        
        switch self.order {
            
        case .desc:
            return self.notificationDic.keys.map { $0 }.sorted(by: {
                if let model1 = Int($0), let model2 = Int($1) {
                    return model1 > model2
                }
                else {
                    return $0 > $1
                }
            })
        case .asc:
            return self.notificationDic.keys.map { $0 }.sorted(by: {
                if let model1 = Int($0), let model2 = Int($1) {
                    return model1 < model2
                }
                else {
                    return $0 < $1
                }
            })
        case .none:
            return self.notificationDic.keys.map { $0 }
        }
    }
    
    /// 新增推播資料
    func addNotification() {
        if let model = willPushNotifications.first {
            self.setDataToDic(models: [model])
            self.willPushNotifications.remove(at: 0)
        }
        
        self.delegate?.fetchDataSuccess()
    }
    /// 刪除推播資料
    func removeNotification() {
        if let key = notificationDic.keys.first {
            self.notificationDic.removeValue(forKey: key)
        }
        
        self.delegate?.fetchDataSuccess()
    }
    
    /// 新增隨機資料
    func addAllShuffledModels() {
        self.order = .none
        self.notificationDic.removeAll()
        self.setDataToDic(models: self.allShuffledArrayPushNotifications)
        
        self.delegate?.fetchDataSuccess()
    }
    
    /// 排序資料
    func sortModels() {
        self.changeOrder()
        self.delegate?.fetchDataSuccess()
    }
    
    /// 切換排序
    /// desc > asc > none
    func changeOrder() {
        switch self.order {
        case .desc:
            self.order = .asc
        case .asc:
            self.order = .none
        case .none:
            self.order = .desc
        }
    }
}
