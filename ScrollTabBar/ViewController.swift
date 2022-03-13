//
//  ViewController.swift
//  ScrollTabBar
//
//  Created by Kim dohyun on 2022/03/13.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {

    
    //MARK: Property
    private let containerView: UIView = {
        return $0
    }(UIView())
    
    private let secondContainerView: UIView = {
        return $0
    }(UIView())
    
    
    private let thirdContainerView: UIView = {
        return $0
    }(UIView())
    
    private let pageView: UIView = {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 2
        return $0
    }(UIView())
    
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var topView: TopNavigationView? = nil
    private let contentView: UIView = UIView()
    private let scrollView: UIScrollView = UIScrollView()
    private let stackView: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDefaultUI()
        // Do any additional setup after loading the view.
    }
    
    private func setUI() {
        topView = TopNavigationView(frame: CGRect(x: 0, y: 44, width: self.view.frame.width, height: 50))
        view.addSubview(topView!)
        view.addSubview(pageView)
        view.addSubview(contentView)
        contentView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.bounces = true
        scrollView.isPagingEnabled = true
        
        view.backgroundColor = .white
        
        
        let firstView = FirstViewController()
        let secondView = SecondViewController()
        let thirdView = ThirdViewController()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        
        containerView.addSubview(firstView.view)
        secondContainerView.addSubview(secondView.view)
        thirdContainerView.addSubview(thirdView.view)
        
        stackView.addSubview(containerView)
        stackView.addSubview(secondContainerView)
        stackView.addSubview(thirdContainerView)

        didMove(toParent: self)
        
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(topView!.snp.bottom)
            $0.left.bottom.equalToSuperview()
            $0.right.equalTo(0)
            $0.width.equalTo(view.frame.width * 3)
        }
        
        
        scrollView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
            $0.width.equalTo(view.frame.width * 3)
        }
        
        
        containerView.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.right.equalTo(secondContainerView.snp.left)
        }
        
        secondContainerView.snp.makeConstraints {
            $0.top.bottom.equalTo(0)
            $0.left.equalTo(containerView.snp.right)
            $0.width.height.equalTo(containerView)
        }
        
        thirdContainerView.snp.makeConstraints {
            $0.top.bottom.equalTo(0)
            $0.left.equalTo(secondContainerView.snp.right)
            $0.right.equalTo(stackView.snp.right)
            $0.width.height.equalTo(containerView)
        }
        
        
        pageView.snp.makeConstraints {
            $0.top.equalTo(topView!.snp.bottom).offset(-2)
            $0.left.equalTo(topView!.button[0].snp.left)
            $0.height.equalTo(3)
            $0.width.equalTo(topView!.button[0].snp.width)
        }
        
        
    }
    
    private func setDefaultUI() {
        topView?.button[0].rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.firstViewDidMove()
            }.disposed(by: disposeBag)
    
        topView?.button[1].rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.secondViewDidMove()
            }.disposed(by: disposeBag)
        
        topView?.button[2].rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.thirdViewDidMove()
            }.disposed(by: disposeBag)
    }
    
    private func firstViewDidMove() {
        let firstView = FirstViewController()
        addChild(firstView)
        containerView.addSubview(firstView.view)
        didMove(toParent: self)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            guard let `self` = self else { return }
            
            self.pageView.snp.remakeConstraints {
                $0.top.equalTo(self.topView!.snp.bottom).offset(-2)
                $0.left.equalTo(self.topView!.button[0].snp.left)
                $0.height.equalTo(3)
                $0.width.equalTo(self.topView!.button[0].snp.width)
            }
            self.view.layoutIfNeeded()
        })
        self.removeFromParent()
        
    }
    
    private func secondViewDidMove() {
        let secondView = SecondViewController()
        addChild(secondView)
        containerView.addSubview(secondView.view)
        didMove(toParent: self)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            guard let `self` = self else { return }
            self.pageView.snp.remakeConstraints {
                $0.top.equalTo(self.topView!.snp.bottom).offset(-2)
                $0.left.equalTo(self.topView!.button[1].snp.left)
                $0.height.equalTo(3)
                $0.width.equalTo(self.topView!.button[1].snp.width)
            }
            self.view.layoutIfNeeded()
        })
        self.removeFromParent()
    }
    
    private func thirdViewDidMove() {
        let thirdView = ThirdViewController()
        addChild(thirdView)
        containerView.addSubview(thirdView.view)
        didMove(toParent: self)
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            guard let `self` = self else { return }
            
            self.pageView.snp.remakeConstraints {
                $0.top.equalTo(self.topView!.snp.bottom).offset(-2)
                $0.left.equalTo(self.topView!.button[2].snp.left)
                $0.height.equalTo(3)
                $0.width.equalTo(self.topView!.button[2].snp.width)

            }
            self.view.layoutIfNeeded()
        })
        self.removeFromParent()
    }


}




class TopNavigationView: UIView {
    //MARK: Property
    private var topView: UIView = {
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
        return $0
    }(UIView())
    
    public var button: [UIButton] = {
        return $0
    }([UIButton]())
    
    public var title: [String] = ["Content1","Content2","Content3"]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configure
    
    private func setUI() {
        addSubview(topView)
        
        button = [UIButton(),UIButton(),UIButton()]
        topView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        button.forEach {
            topView.addSubview($0)
        }
        
        for i in 0..<button.count {
            switch i {
            case 0:
                button[0].setTitle(title[0], for: .normal)
                button[0].setTitleColor(.black, for: .normal)
                button[0].snp.makeConstraints {
                    $0.left.top.bottom.equalTo(0)
                    $0.right.equalTo(button[1].snp.left).offset(0)
                    $0.height.equalTo(topView.snp.height)
                    $0.width.equalTo(button[1])
                }
            case 1:
                button[1].setTitle(title[1], for: .normal)
                button[1].setTitleColor(.black, for: .normal)
                button[1].snp.makeConstraints {
                    $0.top.bottom.equalTo(0)
                    $0.height.equalTo(topView.snp.height)
                    $0.width.equalTo(button[2])
                }
                
            case 2:
                button[2].setTitle(title[2], for: .normal)
                button[2].setTitleColor(.black, for: .normal)
                button[2].snp.makeConstraints {
                    $0.right.top.bottom.equalTo(0)
                    $0.left.equalTo(button[1].snp.right).offset(0)
                    $0.height.equalTo(topView.snp.height)
                }
            default:
                break
            }
        }
    }
}




extension ViewController : UIScrollViewDelegate {
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scroll")
        
        
    }
}
