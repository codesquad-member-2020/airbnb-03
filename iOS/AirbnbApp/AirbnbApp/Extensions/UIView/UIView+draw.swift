import UIKit

extension UIView {
    enum Edge {
        case top, left, bottom, right
    }
    
    func drawEdgeLine(edge: Edge,
                      lineWidth: CGFloat,
                      lineColor: UIColor = .black) {
        let path = UIBezierPath()
        switch edge {
        case .top:
            let startPoint = CGPoint(x: self.bounds.minX,
                                     y: self.bounds.minY)
            path.move(to: startPoint)
            path.addLine(to: CGPoint(x: self.bounds.maxX,
                                     y: self.bounds.minY))
            path.addLine(to: CGPoint(x: self.bounds.maxX,
                                     y: self.bounds.minY + lineWidth))
            path.addLine(to: CGPoint(x: self.bounds.minX,
                                     y: self.bounds.minY + lineWidth))
            path.addLine(to: startPoint)
        case .left:
            let startPoint = CGPoint(x: self.bounds.minX,
                                     y: self.bounds.minY)
            path.move(to: startPoint)
            path.addLine(to: CGPoint(x: self.bounds.minX + lineWidth,
                                     y: self.bounds.minY))
            path.addLine(to: CGPoint(x: self.bounds.minX + lineWidth,
                                     y: self.bounds.maxY))
            path.addLine(to: CGPoint(x: self.bounds.minX,
                                     y: self.bounds.maxY))
            path.addLine(to: startPoint)
        case .bottom:
            let startPoint = CGPoint(x: self.bounds.minX,
                                     y: self.bounds.maxY - lineWidth)
            path.move(to: startPoint)
            path.addLine(to: CGPoint(x: self.bounds.maxX,
                                     y: self.bounds.maxY - lineWidth))
            path.addLine(to: CGPoint(x: self.bounds.maxX,
                                     y: self.bounds.maxY))
            path.addLine(to: CGPoint(x: self.bounds.minX,
                                     y: self.bounds.maxY))
            path.addLine(to: startPoint)
        case .right:
            let startPoint = CGPoint(x: self.bounds.maxX - lineWidth,
                                     y: self.bounds.minY)
            path.move(to: startPoint)
            path.addLine(to: CGPoint(x: self.bounds.maxX,
                                     y: self.bounds.minY))
            path.addLine(to: CGPoint(x: self.bounds.maxX,
                                     y: self.bounds.maxY))
            path.addLine(to: CGPoint(x: self.bounds.maxX - lineWidth,
                                     y: self.bounds.maxY))
            path.addLine(to: startPoint)
        }
        
        lineColor.setFill()
        path.close()
        path.fill()
    }
}
