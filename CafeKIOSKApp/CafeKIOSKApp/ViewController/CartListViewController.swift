//
//  CartTableViewController.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/5/26.
//

import UIKit
import Then
import SnapKit

class CartTableViewController: UIViewController {

    // 1. 데이터 인스턴스 & 데이터를 담을 빈배열 (CartManager의 items를 가져옴)
    let dataService = CoffeeMenuDataService()
    var cartList = [CartItem]()
    
    // 2. 테이블 뷰 생성하기
    private let tableView = UITableView().then {
        $0.rowHeight = 120 // 셀 높이
    }
    
    // 3. 하단 버튼 뷰 생성
    private let bottomView = CartBottomView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView() // 테이블 준비
        fetchData()      // 데이터 가져와
        
        setupCartBottomView() // 하단부 구현
    }
    
    // 4. 실제 데이터를 가져와서 장바구니에 넣는 함수
    func fetchData() {
        dataService.loadMenu { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                // 전체 메뉴 리스트 가져옴
                let menuItems = response.items
                
                // 1) 아메리카노 찾아서 담기 (1잔, 핫, 1샷)
                if let americano = menuItems.first(where: { $0.name == "아메리카노" }) {
                    let item = CartItem(menu: americano, isIce: false, shotCount: 1, count: 1)
                    self.cartList.append(item)
                }
                
                // 2) 딸기 스무디(S03) 찾아서 담기 (1잔, 샷추가 2번)
                if let smoothie = menuItems.first(where: { $0.id == "S03" }) {
                    let item = CartItem(menu: smoothie, isIce: true, shotCount: 2, count: 1)
                    self.cartList.append(item)
                }
                
                // 3) 로꾸거 찾아서 담기 (1잔)
                if let americano = menuItems.first(where: { $0.name == "로꾸거 딸기젤라또 콘케이크" }) {
                    let item = CartItem(menu: americano, isIce: false, shotCount: 2, count: 1)
                    self.cartList.append(item)
                }
                
                // 4) 데이터가 준비되었으니 화면을 갱신하라고 알림 (메인 스레드에서)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print("데이터 가져오기 실패: \(error)")
            }
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        // 테이블 뷰에 셀 등록
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self

        // 테이블뷰 위치 잡기
        tableView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.bottom.equalTo(bottomView.snp.top)
        }
        
        // 테두리 둘글게
        tableView.layer.cornerRadius = 15
    }
    
    func setupCartBottomView() {
        view.addSubview(bottomView)

        // 하단의 버튼 뷰
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(30)
        }
    }
}

extension CartTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 몇 개의 셀을 보여줄지
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count // 배열 원소의 수
    }
    
    // 각 셀에 뭘 보여줄지
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        
        let item = cartList[indexPath.row]
        cell.configure(with: item) // 셀에 데이터 전달하기
        
        cell.removeAction = { [weak self] in
            guard let self else { return }
            
            self.cartList.remove(at: indexPath.row)
            
            self.tableView.reloadData()
        }
        
        
        return cell
    }
}


#Preview {
    CartTableViewController()
}
