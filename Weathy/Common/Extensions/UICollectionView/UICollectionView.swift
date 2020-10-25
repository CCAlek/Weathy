//
//  UICollectionView.swift
//  Weathy
//
//  Created by Семен Семенов on 25.10.2020.
//

import UIKit

extension UICollectionView {
    
    static func defaultReuseId(for elementType: UIView.Type) -> String {
        return String(describing: elementType)
    }
    
    func dequeueReusableCellWithRegistration<T: UICollectionViewCell>(type: T.Type, indexPath: IndexPath, reuseId: String? = nil) -> T {
        let normalizedReuseId = reuseId ?? UICollectionView.defaultReuseId(for: T.self)
        
        register(type, forCellWithReuseIdentifier: normalizedReuseId)
        return dequeueReusableCell(withReuseIdentifier: normalizedReuseId, for: indexPath) as! T
    }
}
