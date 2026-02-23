import UIKit

final class ImagesListCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var cellImage: UIImageView!
    
    static let reuseIdentifier = "ImagesListCell"
}
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        addGradient()
//    }

//    // MARK: - Private Methods
//    private func addGradient() {
//        let gradient = CAGradientLayer()
//        
//        // #1A1B22
//        let color = UIColor(
//            red: 26/255,
//            green: 27/255,
//            blue: 34/255,
//            alpha: 1.0
//        )
//        
//        gradient.frame = bounds
//        
//        // Направление: сверху вниз (равномерно)
//        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)  // верх
//        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)    // низ
//        
//        // ЕЛЕ ЗАМЕТНЫЙ градиент
//        gradient.colors = [
//            color.withAlphaComponent(0.0).cgColor,  // сверху прозрачный
//            color.withAlphaComponent(0.1).cgColor   // снизу чуть-чуть темнее (10%)
//        ]
//        
//        // Равномерное распределение
//        gradient.locations = [0.0, 1.0]
//        
//        // Добавляем в ячейку (под текст)
//        layer.insertSublayer(gradient, at: 0)
//        
//        bringSubviewToFront(dateLabel)
//        
//        // Белый текст
//        dateLabel.textColor = .white
//        dateLabel.backgroundColor = .clear
//    }
