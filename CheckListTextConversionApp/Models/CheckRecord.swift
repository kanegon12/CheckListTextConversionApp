//
//  CheckRecord.swift
//  CheckListTextConversionApp
//
//  Created by 金子朝紀 on 2026/05/01.
//

import Foundation
import SwiftData

@Model
final class CheckRecord {
    
    var recordId: String
    var recordTemplateId: String
    var checkStatus: [String: Bool]
    var textValues: [String: String]
    var numberValues: [String: String]
    var dateValues: [String: Date]
    var recordUpdateAt: Date
    
    init(templateId: String) {
        self.recordId = UUID().uuidString
        self.recordTemplateId = templateId
        self.checkStatus = [:]
        self.textValues = [:]
        self.numberValues = [:]
        self.dateValues = [:]
        self.recordUpdateAt = Date()
    }
}
