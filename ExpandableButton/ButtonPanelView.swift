//
//  ButtonPanelView.swift
//  ExpandableButton
//
//  Created by Akshuma Trivedi on 26/07/20.
//  Copyright © 2020 Akshuma Trivedi. All rights reserved.
//

import UIKit

fileprivate let buttonSize: CGFloat = 56
fileprivate let shadowOpacity: Float = 0.7
    
protocol ButtonPanelDelegate: NSObject {

  
  /// Notifies the delegate that a button in the panel was tapped.
  /// - Parameter text: The text in the button that was tapped.
  func didTapButtonWithText(_ text: String)
}


class ButtonPanelView: UIView {

    weak var delegate: ButtonPanelDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 81/255, green: 166/255, blue: 219/255, alpha: 1.0)
        layer.cornerRadius = buttonSize / 2
        layer.shadowColor = UIColor.lightText.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = .zero
        addSubview(containerStackView)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints()  {
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        option1Button.translatesAutoresizingMaskIntoConstraints = false
        option1Button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        option1Button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        option2Button.translatesAutoresizingMaskIntoConstraints = false
        option2Button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        option2Button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: containerStackView.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: containerStackView.heightAnchor).isActive = true

        
    }
    
    lazy var menuButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("➕", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = buttonSize / 2
        button.addTarget(self, action:#selector(togglebuttonTapped) , for: .touchUpInside)
        return button
    }()
    
    lazy var option1Button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("🐶", for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = buttonSize / 2
        button.isHidden = true
        button.addTarget(
             self, action: #selector(optionExpandedButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var option2Button: UIButton = {
           let button = UIButton(frame: .zero)
           button.setTitle("🐱", for: .normal)
           button.backgroundColor = .clear
           button.layer.cornerRadius = buttonSize / 2
           button.isHidden = true
        button.addTarget(
             self, action: #selector(optionExpandedButtonTapped(_:)), for: .touchUpInside)
           return button
       }()
    
    lazy var expandingStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.isHidden = true
        stackview.addArrangedSubview(option1Button)
        stackview.addArrangedSubview(option2Button)
        return stackview
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.addArrangedSubview(expandingStackView)
        stackview.addArrangedSubview(menuButton)
        return stackview
    }()
    
}
extension ButtonPanelView {
    @objc private func togglebuttonTapped(_ sender: UIButton) {
        let willExpand = expandingStackView.isHidden
        let menuButtonTile = willExpand ?  "❌" : "➕"
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.expandingStackView.subviews.forEach{$0.isHidden = !$0.isHidden}
            self.expandingStackView.isHidden = !self.expandingStackView.isHidden
            if willExpand {
                self.menuButton.setTitle(menuButtonTile, for: .normal)
            }
        }, completion: { _ in
            if !willExpand {
                self.menuButton.setTitle(menuButtonTile, for: .normal)
            }
            
        })
    }
   @objc func optionExpandedButtonTapped(_ sender: UIButton) {
        guard let label = sender.titleLabel, let text = label.text else { return }
           delegate?.didTapButtonWithText(text)
    }
    
}
