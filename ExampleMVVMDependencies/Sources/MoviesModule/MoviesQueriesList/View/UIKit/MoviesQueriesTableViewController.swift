//
//  MoviesQueriesTableViewController.swift
//  ExampleMVVM
//
//  Created by Oleh on 03.10.18.
//

import Common
import UIKit

public final class MoviesQueriesTableViewController: UITableViewController {
    private var viewModel: MoviesQueryListViewModel!

    // MARK: - Lifecycle

    static func create(with viewModel: MoviesQueryListViewModel) -> MoviesQueriesTableViewController {
        let view = UIStoryboard(name: "MoviesQueriesTableViewController", bundle: .module).instantiateViewController(withIdentifier: "MoviesQueriesTableViewController") as! MoviesQueriesTableViewController
        view.viewModel = viewModel
        return view
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind(to: viewModel)
    }

    private func bind(to viewModel: MoviesQueryListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.viewWillAppear()
    }

    // MARK: - Private

    private func setupViews() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = MoviesQueriesItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

public extension MoviesQueriesTableViewController {
    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.items.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesQueriesItemCell.reuseIdentifier, for: indexPath) as? MoviesQueriesItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(MoviesQueriesItemCell.self) with reuseIdentifier: \(MoviesQueriesItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        cell.fill(with: viewModel.items.value[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewModel.didSelect(item: viewModel.items.value[indexPath.row])
    }
}
