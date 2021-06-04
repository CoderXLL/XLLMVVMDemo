//
//  day01-UITableView_RX.swift
//  XLLMVVMDemo
//
//  Created by xiaoll on 2021/6/3.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct XLLViewModel01 {
    let data = Observable.just([
            "小糊涂神",
            "大尾巴狼",
            "猫和老鼠",
            "数码宝贝56"
        ]
    )
}

//自定义binder
extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self) { label, fontSize in
            label.font = .systemFont(ofSize: fontSize)
        }
    }
}

class XLLViewController01: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.tableView)
        view.addSubview(self.test1Label)
        
        viewModel.data.bind(to: tableView.rx.items(cellIdentifier: "hahaha")) { _, item, cell in
            cell.textLabel?.text = item
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected(String.self).subscribe {
            print("您已选中\(String(describing: $0.element))")
        }.disposed(by: disposeBag)
        
        Observable.from(["H", "I", "J"]).subscribe {
            print("输出\($0)")
        }.disposed(by: disposeBag)
        Observable.of("A", "B", "C").subscribe {
            print("输出\($0)")
        }.disposed(by: disposeBag)
        Observable.of(["D", "E", "F"]).subscribe {
            print("输出\($0)")
        }.disposed(by: disposeBag)
        Observable.just(["O", "P", "Q"]).subscribe {
            print("输出\($0)")
        }.disposed(by: disposeBag)
        
        
        Observable.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).filter({
            return $0 < 10
        }).bind {
            self.test1Label.text = "\($0)"
        }.disposed(by: disposeBag)
        
        
        Observable.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).map({
            return $0 % 2 == 0
        }).bind {
            self.test1Label.textColor = $0 ? .green : .blue
        }.disposed(by: disposeBag)
        
        Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).map({
            return CGFloat($0)
        }).bind(to: self.test1Label.fontSize).disposed(by: disposeBag)
        
        
    }
    
    // MARK: - lazy loading
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 120), style: .grouped)
        tableView.backgroundColor = .red
        tableView.estimatedRowHeight = 40
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "hahaha")
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        return tableView
    }()
    
    private lazy var test1Label: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 240, width: 100, height: 20))
        label.textAlignment = .left
        label.textColor = .red
        return label
    }()
    
    private lazy var viewModel: XLLViewModel01 = {
        let viewModel = XLLViewModel01()
        return viewModel
    }()
}
