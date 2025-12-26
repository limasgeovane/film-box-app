import UIKit

protocol DynamicHeightGridViewDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

protocol DynamicHeightSizingProvider: AnyObject {
    func heightForItem(at indexPath: IndexPath, in width: CGFloat) -> CGFloat
}

final class DynamicHeightGridView: UICollectionViewLayout {
    weak var delegate: DynamicHeightGridViewDelegate?
    weak var sizingProvider: DynamicHeightSizingProvider?
    
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 8
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        cache.removeAll()
        contentHeight = 0
        
        guard let collectionView = collectionView else { return }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        let xOffset: [CGFloat] = (0..<numberOfColumns).map { CGFloat($0) * columnWidth }
        
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        var column = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let measuredHeight: CGFloat
            
            if let sizingProvider {
                measuredHeight = sizingProvider.heightForItem(at: indexPath, in: columnWidth - (cellPadding * 2))
            } else {
                measuredHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? 180
            }
            
            let height = (cellPadding * 2) + measuredHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] += height
            column = yOffset[0] > yOffset[1] ? 1 : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cache.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cache[indexPath.item]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return true }
        return newBounds.size != collectionView.bounds.size
    }
}
