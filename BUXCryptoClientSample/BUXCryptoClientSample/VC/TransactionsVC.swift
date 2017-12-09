//
//  TransactionsVC.swift
//  BUXCryptoClientSample
//
//  Created by Alexey Savchenko on 09.12.2017.
//  Copyright © 2017 BUX. All rights reserved.
//

import UIKit

class TransactionsVC: UIViewController {
  
  let transactionListTableView = UITableView()
  
  weak var viewModel: TransactionsViewModelType?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
  }
  
  private func listSetUp() {
    
    transactionListTableView.delegate = self
    transactionListTableView.dataSource = self
    
    transactionListTableView.register(UINib.init(nibName: "TransactionListCell", bundle: nil), forCellReuseIdentifier: "TransactionListCell")
    
    view.addSubview(transactionListTableView)
    transactionListTableView.translatesAutoresizingMaskIntoConstraints = false
    
    let safeArea = view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([transactionListTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                                 transactionListTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
                                 transactionListTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                                 transactionListTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)])
    
    
  }
  
  
}

extension TransactionsVC: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return viewModel?.transactionsCount ?? 0
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionListCell", for: indexPath) as! TransactionListCell
    viewModel?.configureCell(cell, indexPath: indexPath)
    return cell
    
  }
  
}
