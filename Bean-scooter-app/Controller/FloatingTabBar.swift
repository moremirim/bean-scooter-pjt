//
//  FloatingTabBar.swift
//  Bean-scooter-app
//
//  Created by 박중권 on 4/24/24.
//

import UIKit

protocol FloatingTabBarDelegate: AnyObject {
    func didSelectTab(at index: Int)
}

class FloatingTabBar: UIView {
    
    weak var delegate: FloatingTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTabBar()
    }
    
    private func setupTabBar() {

        // Example buttons
        let buttonTitles = ["Button 1", "Button 2", "Button 3", "Button 4"]
        let buttonWidth = frame.width / CGFloat(buttonTitles.count)
        
        for (index, title) in buttonTitles.enumerated() {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: CGFloat(index) * buttonWidth, y: 0, width: buttonWidth, height: frame.height)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            addSubview(button)
        }
    }
    
    @objc private func tabButtonTapped(_ sender: UIButton) {
        guard let index = subviews.firstIndex(of: sender) else { return }
        delegate?.didSelectTab(at: index)
    }
}

