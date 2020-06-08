import Foundation

protocol SectionDetailViewFactory {
    static func makeView(for stayDetail: StayDetail) -> ContentView
}
