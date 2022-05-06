//
//  DateViewModel.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/04/29.
//

import SwiftUI

final class DateViewModel: ObservableObject {
    @Published var text: String = "Hello, world!!!"
    
    let dateModel: DateProtocol
    
    ///本番用DateModel() ⇔ モック用MockDateModel()に切り替えられるようにしておく
    init(dateModel: DateProtocol = DateModel()) {
        self.dateModel = dateModel
    }
    
    func isHoliday() -> Bool {
        ///DateProtocol経由で現在時刻を取得
        let now = dateModel.now()
        
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: now)
        
        return weekday == 1 || weekday == 7
    }

}
