//
//  CartTableViewController.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/5/26.
//

import UIKit
import Then
import SnapKit

class CartViewController: UIViewController {
    
    // 1. 메인뷰로 사용할 CartView의 인스턴스 만들고 VM 인스턴스도 만듬
    private let cartView = CartView()
    private let viewModel = CartViewModel()
    
    // 2. 메인뷰를 cartview로 교체
    override func loadView() {
        self.view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTableView()
        setupBindings()
        
        //데이터 가져오기
        viewModel.fetchData()
    }
    
    // 테이블뷰 델리게이트 설정하기
    private func setupTableView() {
        cartView.tableView.dataSource = self
        cartView.tableView.delegate = self
    }
    // 클로저 연결
    private func setupBindings() {
        viewModel.dataChanged = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.cartView.tableView.reloadData()
                self.cartView.bottomView.updatePrice(self.viewModel.totalPrice)
            }
            
            cartView.bottomView.OrderButtonTapped = {
                print("주문이 완료도ㅛㅣ엇스ㅜㅂ니다.")
            }
            
            
        }
    }
    
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 몇 개의 셀을 보여줄지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    // 각 셀에 뭘 보여줄지
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.item(at: indexPath.row)
        cell.configure(with: item) // 셀에 데이터 전달하기
        
        cell.removeAction = { [weak self] in
            self?.viewModel.removeItem(at: indexPath.row)
        }
        
        
        return cell
    }
    
}
#Preview {
    CartViewController()
}
