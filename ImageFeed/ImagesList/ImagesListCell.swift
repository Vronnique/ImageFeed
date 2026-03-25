import UIKit

final class ImagesListCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var cellImage: UIImageView!
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ImagesListCell"
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = cellImage.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.image = nil
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        dateLabel.textColor = .white
        dateLabel.backgroundColor = .clear
        
        cellImage.clipsToBounds = true
        cellImage.contentMode = .scaleAspectFill
    }
    
    private func setupGradient() {
        // #1A1B22
        let color = UIColor(
            red: 26/255,
            green: 27/255,
            blue: 34/255,
            alpha: 1.0
        )
        
        // Направление:
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations = [0.0, 1.0]
        
        gradientLayer.colors = [
            color.withAlphaComponent(0.0).cgColor,
            color.withAlphaComponent(0.6).cgColor
        ]
        
        // Добавляем в imageView
        cellImage.layer.addSublayer(gradientLayer)
    }
    
}
