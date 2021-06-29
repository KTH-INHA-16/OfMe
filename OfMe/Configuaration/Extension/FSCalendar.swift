import Foundation
import UIKit
import FSCalendar

extension FSCalendar {
//    func setFont() {
//        self.appearance.headerTitleFont = .NaNum(.extraBold, size: 18)
//        self.appearance.titleFont = .NaNum(.extraBold, size: 15)
//        self.appearance.weekdayFont = .NaNum(.regular, size: 12)
//    }
    
    func setColor() {
        self.appearance.eventSelectionColor = .clear
        self.appearance.selectionColor = .clear
        self.appearance.todayColor = .clear
    }
    
    func setApperance() {
        self.weekdayHeight = 60
        self.rowHeight = 44
    }
}
