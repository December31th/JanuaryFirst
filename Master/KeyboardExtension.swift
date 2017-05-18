//
//  KeyboardExtension.swift
//
//
//  Created by Alpaca on 2017. 2. 5..
//
//

import Foundation

extension SettingsViewController {
    // 키보드가 떠오를 때 발생하는 이벤트 처리
    func keyboardWillShow(notification: NSNotification) {
        debugPrint("keyboard will show")
        keyboardYN = true
        let userInfo = notification.userInfo!
        rectKeyboard = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        // 스크롤이 가능한 경우
        let collectionViewOffset = self.collectionView.contentOffset
        let ac
    }
}
