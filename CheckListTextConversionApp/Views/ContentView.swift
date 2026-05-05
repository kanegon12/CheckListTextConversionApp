//
//  ContentView.swift
//  CheckListTextConversionApp
//
//  Created by 金子朝紀 on 2026/04/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        TemplateListView()
    }
  
}

#Preview {
    ContentView()
        .modelContainer(for: Template.self, inMemory: true)
}
