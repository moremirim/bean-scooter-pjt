//
//  LaunchViewController.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/26/24.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView1.center = view.center
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
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
                guard let viewController = self.storyboard?.instantiateViewController(identifier: "SigninVC") as? SignInViewController else {
                    return
                }

                self.navigationController?.pushViewController(viewController, animated: true)
            }
        })
        
        
        
    }

}
