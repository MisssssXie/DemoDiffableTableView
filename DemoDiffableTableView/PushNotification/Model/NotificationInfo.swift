//
//  NotificationInfo.swift
//  DemoDiffableTableView
//
//  Created by Sally Xie on 2022/11/20.
//

import Foundation

struct NotificationInfo: Hashable {
    let date: String
    let content: String

    /// 預設初始資料
    static let fakeNotifications = [NotificationInfo(date: "2022/11/11", content: "我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦"), NotificationInfo(date: "2022/11/12", content: "我推播啦"), NotificationInfo(date: "2022/11/13", content: "我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦")]
    /// 預設可新增資料
    static let willPushNotifications = [NotificationInfo(date: "2022/11/12", content: "我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦"), NotificationInfo(date: "2022/11/14", content: "我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦"), NotificationInfo(date: "2022/11/15", content: "我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦"), NotificationInfo(date: "2022/11/12", content: "我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦我推播啦")]

    /// 全部亂序資料
    static var allShuffledArrayPushNotifications: [NotificationInfo] = {
        var array: [NotificationInfo] = []
        for i in 0 ... 20 {
            array.append(NotificationInfo(date: "\(i)", content: "\(i)"))
        }

        let shuffledArray = array.shuffled()

        return shuffledArray
    }()

    /// 全部排序過資料
    static var allSortPushNotifications: [NotificationInfo] = {
        let shuffledArray = allShuffledArrayPushNotifications
        let sorted = shuffledArray.sorted(by: { $0.date < $1.date })

        return sorted
    }()
}
