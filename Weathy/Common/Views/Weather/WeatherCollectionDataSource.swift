//
//  WeatherCollectionDataSource.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import UIKit

class WeatherCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var representableViewModels: [WeatherInformationViewModel]
    
    init(viewModels: [WeatherInformationViewModel] = []) {
        self.representableViewModels = viewModels
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return representableViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithRegistration(type: WeatherInformationCollectionCell.self, indexPath: indexPath)
        guard let viewModel = self.representableViewModels[safe: indexPath.row] else { return cell }
        cell.configure(with: viewModel)
        return cell
    }
}
