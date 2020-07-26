//
//  ViewController.swift
//  ExpandableButton
//
//  Created by Akshuma Trivedi on 26/07/20.
//  Copyright © 2020 Akshuma Trivedi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  private let buttonPanelView = ButtonPanelView()
  private let label = UILabel()

    
  override func viewDidLoad() {
    super.viewDidLoad()

    label.text = "Tap!"
    label.sizeToFit()
    view.addSubview(label)
    buttonPanelView.delegate = self
    view.addSubview(buttonPanelView)
    addConstraints()
  }

  private func addConstraints() {
    buttonPanelView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    buttonPanelView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    label.topAnchor.constraint(equalTo: buttonPanelView.bottomAnchor, constant: 35).isActive = true
    label.translatesAutoresizingMaskIntoConstraints = false
    label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  }
}

extension ViewController: ButtonPanelDelegate {
  func didTapButtonWithText(_ text: String) {
    guard text != label.text else { return }
    label.text = text
  }
}
