//
//  InputView.swift
//  Todo
//
//  Created by ちゅーたつ on 2017/10/15.
//  Copyright © 2017年 ちゅーたつ. All rights reserved.
//

import UIKit

enum InputButtonState {
    
    case write
    case cancel
}


protocol InputButtonTouchUpDelegate {
    
    func touchUpInputButton(_ textField: UITextField, inputView: InputView) -> Void
}

class InputView: UIView, NibLoadable {
    
    
    var delegate: InputButtonTouchUpDelegate?
    var state: InputButtonState = .cancel
    
    
    @IBOutlet weak var textField: UITextField! {
        
        didSet {
            
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
        if textField.text!.isEmpty {
            
            self.state = .cancel
            inputButton.setTitle("閉じる", for: .normal)
        }
        else {
            
            self.state = .write
            inputButton.setTitle("完了", for: .normal)
        }
    }

    @IBOutlet weak var inputButton: UIButton! {
    
        didSet {
        
            inputButton.addTarget(self, action: #selector(inputButtonTouchUpInside), for: .touchUpInside)
        }
    }
    
    private dynamic func  inputButtonTouchUpInside() {
        
        self.delegate?.touchUpInputButton(self.textField, inputView: self)
    }
}


    


