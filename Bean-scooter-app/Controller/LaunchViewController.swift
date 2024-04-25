//
//  LaunchViewController.swift
//  Bean-scooter-app
//
//  Created by 박중권 on 4/25/24.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView1: UIImageView!
    
    //이미지 삽입
//    private let imageView: UIImageView = {
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 120))
//        imageView.image = UIImage(named: "forBeanLogo")
//        return imageView
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView1)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView1.center = view.center
        
        //애니메이션 몇 초 후에 나오게 할 건지 설정
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: self.animate)
    }
    
    
    private func animate() {
        UIView.animate(withDuration: 2, animations: {
            let size = self.view.frame.size.width * 4.3333
            let diffX = size - self.view.frame.size.width
            let diffY = size - self.view.frame.size.height - size
            
            
            self.imageView1.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
            
        })
        
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView1.alpha = 0
            
        }, completion: { done in
            if done {
                guard let viewController = self.storyboard?.instantiateViewController(identifier: "SignInVC") as? SignInViewController else {
                    return
                }
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            }
        })
        
        
        
    }
}


