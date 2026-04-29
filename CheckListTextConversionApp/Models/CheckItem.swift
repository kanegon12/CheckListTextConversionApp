//
//  CheckItem.swift
//  CheckListTextConversionApp
//
//  Created by 金子朝紀 on 2026/04/30.
//

import Foundation
import SwiftData
import SwiftUI

enum ItemType: String, Codable {
    case checkbox
    case text
    case number
    case date
    
    // バッジに表示するテキスト
    var displayName: String {
        switch self {
        case .checkbox:
            return "チェックボックス"
        case .text:
            return "テキスト"
        case .number:
            return "数字"
        case .date:
            return "日付"
        }
    }
    
    // バッジの色
    var badgeColor: Color {
        switch self {
        case .checkbox:
            return .green
        case .text:
            return .blue
        case .number:
            return .orange
        case .date:
            return .purple
        }
    }
    
}

@Model
final class CheckItem {
    
    var itemId: String
    var itemType: ItemType
    var itemLabel: String
    var itemUnit: String?
    var itemOrder: Int
    var section: TemplateSection?
    
    init(type: ItemType, label: String, unit: String? = nil, order:Int){
        
        self.itemId = UUID().uuidString
        self.itemType = type
        self.itemLabel = label
        self.itemUnit = unit
        self.itemOrder = order
    }
}
