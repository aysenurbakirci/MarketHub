//
//  ProductDetailViewController.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import UIKit

protocol ProductDetailViewing: AnyObject {
  func update(with viewModels: ProductDetailViewModels?)
  func showLoadingView()
  func hideLoadingView()
}

final class ProductDetailViewController: UIViewController {
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.backgroundColor = Color.containerBackground
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
    
  private lazy var loadingView: LoadingView = {
    let loadingView = LoadingView()
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    return loadingView
  }()
    
  var presenter: ProductDetailPresenting?
  private var viewModels: ProductDetailViewModels?

  override func viewDidLoad() {
    super.viewDidLoad()
    registerCells()
    setupViews()
    setupConstraints()
    setupAccessibilityIdentifiers()
    presenter?.viewDidLoad()
  }
    
  func registerCells() {
    tableView.register(
      ImageSliderCell.self,
      forCellReuseIdentifier: ImageSliderCell.reuseIdentifier
    )
    tableView.register(
      ProductInformationCell.self,
      forCellReuseIdentifier: ProductInformationCell.reuseIdentifier
    )
    tableView.register(
      ProductRatingInformationCell.self,
      forCellReuseIdentifier: ProductRatingInformationCell.reuseIdentifier
    )
    tableView.register(
      ProductPriceInformationCell.self,
      forCellReuseIdentifier: ProductPriceInformationCell.reuseIdentifier
    )
  }

  private func setupViews() {
    view.addSubview(tableView)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
  }
    
  private func setupAccessibilityIdentifiers() {
    tableView.accessibilityIdentifier = AccessibilityIdentifiers.detailPage
  }
}

extension ProductDetailViewController: ProductDetailViewing {
  func update(with viewModels: ProductDetailViewModels?) {
    self.viewModels = viewModels
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
    
  func showLoadingView() {
    view.addSubview(loadingView)
    NSLayoutConstraint.activate([
      loadingView.topAnchor.constraint(equalTo: view.topAnchor),
      loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }

  func hideLoadingView() {
    loadingView.removeFromSuperview()
  }
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    viewModels?.cellViewModels.count ?? 0
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let viewModel = viewModels?.cellViewModels[safe: indexPath.row],
      let cell = tableView.dequeueReusableCell(
        withIdentifier: viewModel.cell.reuseIdentifier,
        for: indexPath) as? ReusableTableViewCell
    else {
      return UITableViewCell()
    }
    cell.update(with: viewModel)
    return cell
  }
}
