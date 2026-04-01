import UIKit

final class SingleImageViewController: UIViewController {
    
    // MARK: - Properties
    
    var image: UIImage?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sharingButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = image else {
            return
        }
        
        imageView.image = image
        imageView.frame.size = image.size
        rescaleAndCenterImageInScrollView(image: image)
            
        scrollView.maximumZoomScale = 1.25
        scrollView.minimumZoomScale = 0.1
    }
    
    // MARK: - Private Methods
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, min(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        
        updateContentInset()
        
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapBackwardButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSharingButton() {
        guard let image = image else {
            return
        }
        
        let share = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        
        present(share, animated: true)
    }
    
}

// MARK: - UIScrollViewDelegate

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateContentInset()
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        updateContentInset()
    }
    
    // метод центрирования
    private func updateContentInset() {
           let scrollViewSize = scrollView.bounds.size
           let imageViewSize = imageView.frame.size
           
           let verticalInset = max(0, (scrollViewSize.height - imageViewSize.height) / 2)
           let horizontalInset = max(0, (scrollViewSize.width - imageViewSize.width) / 2)
           
           scrollView.contentInset = UIEdgeInsets(
               top: verticalInset,
               left: horizontalInset,
               bottom: verticalInset,
               right: horizontalInset
           )
       }
}
