//
//  WeatherTableDataSource.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import UIKit

class WeatherTableDataSource: NSObject, UITableViewDataSource {

    var representableViewModel: WeatherViewModel

    init(viewModel: WeatherViewModel = WeatherViewModel()) {
        self.representableViewModel = viewModel
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representableViewModel.rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = representableViewModel.rows[safe: indexPath.row] else { return UITableViewCell() }
        return getCell(type: type, tableView: tableView, indexPath: indexPath)
    }
}

extension WeatherTableDataSource {
    private func getCell(type: WeatherRowType, tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case let .title(viewModel):
            let cell = tableView.dequeueReusableCellWithRegistration(type: WeatherTitleCell.self, indexPath: indexPath)
            cell.configure(with: viewModel)
            return cell
        case .information:
            return UITableViewCell()
        }
    }
}
