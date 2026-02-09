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
    
    // 메인뷰로 사용할 CartView의 인스턴스 만들고 VM 인스턴스도 만듬
    private let cartView = CartView()
    
//    private let viewModel = CartViewModel(cartManager: CartManager())
    
    // 외부에서 주입받을 변수
    private let viewModel: CartViewModel
    
    // 생성자 추가: 외부에서 만든 ViewModel을 받음
    init(cartManager: CartManager) {
        self.viewModel = CartViewModel(cartManager: cartManager)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 메인뷰를 cartview로 교체
    override func loadView() {
        self.view = cartView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 화면이 나타날 때마다 최신 데이터를 가져옴
        viewModel.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar() // 네비게이션바 셋업
        setupTableView() // 테이블뷰 셋업
        setupBindings() // VM과 View 연결
//        
//        //데이터 가져오기
        viewModel.fetchData()
        
//        // 뷰모델이 "데이터 바뀌었다(dataChanged)"고 신호주면 테이블뷰 리로드
//        viewModel.dataChanged = { [weak self] in
//            self?.cartView.tableView.reloadData()
//        }
    }
    
    private func setupNavigationBar() {
        self.title = "주문하기"
        
        // Large Title 끄기 (이게 켜져 있으면 무조건 왼쪽 정렬)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        // 타이틀 폰트를 키우고 싶다면 Appearance 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        // 타이틀 속성 설정
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 23, weight: .bold)
        ]
        
        // 설정 적용
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 뒤로가기 버튼 색상
        self.navigationController?.navigationBar.tintColor = .black
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
            // View 업데이트
            DispatchQueue.main.async {
                self.cartView.tableView.reloadData()
                self.cartView.bottomView.updatePrice(self.viewModel.totalPrice)
                self.cartView.topView.updateStatus(selectedCount: self.viewModel.selectedCount, totalCount: self.viewModel.rowCount)
            }
            
            // 주문 버튼
            cartView.bottomView.OrderButtonTapped = { [weak self] in
                // 팝업창 만들기
                let alert = UIAlertController(
                    title: "주문 완료",
                    message: "주문이 성공적으로 접수되었습니다.\n잠시만 기다려주세요.",
                    preferredStyle: .alert
                )
                
                // 버튼 만들기
                let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                    // 확인 버튼을 눌렀을 때 실행할 코드
                    print("확인 버튼 눌림")
                }
                
                // 팝업창에 버튼 추가하기
                alert.addAction(okAction)
                
                // 화면에 띄우기
                self?.present(alert, animated: true, completion: nil)
            }
            
        }
        // view에서 전달받음
        cartView.topView.selectAllAction = { [weak self] in
            // VM으로 전달함
            self?.viewModel.ToggleAllSelection()
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
            self?.viewModel.removeItem(at: indexPath.row)}
        
        cell.plusAction = { [weak self] in
            self?.viewModel.increaseCount(at: indexPath.row)}
        
        cell.minusAction = { [weak self] in
            self?.viewModel.decreaseCount(at: indexPath.row)}
        
        cell.checkAction = { [weak self] in
            self?.viewModel.toggleSelection(at: indexPath.row)}
        
        return cell
    }
    
}
