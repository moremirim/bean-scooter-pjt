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
        
        // 이미지 뷰를 화면 중앙에 위치
        imageView1.center = view.center
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 1.5초 후에 애니메이션을 실행하는 함수를 실행
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute: self.animate)
    }
    
    // 이미지 뷰를 확대하는 애니메이션을 적용
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
        
        // 이미지 뷰를 투명하게 만들고 애니메이션이 완료되면 로그인 화면으로 전환
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView1.alpha = 0
            
        }, completion: { done in
            if done {
                // Storyboard에서 로그인 화면 뷰 컨트롤러를 가져와서 화면 전환
                guard let viewController = self.storyboard?.instantiateViewController(identifier: "SigninVC") as? SignInViewController else {
                    return
                }

                self.navigationController?.pushViewController(viewController, animated: true)
            }
        })
        
        
        
    }

}
