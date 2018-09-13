import Clibvisionworks


public class VirtualImage: Referenceable, Imageable {
  public let reference: vx_image

  public required init(reference: vx_image) {
    vxRetainReference(reference)
    self.reference = reference
  }

  public init!(graph: Graph, width: Int = 0, height: Int = 0, type: ImageType = .Virtual) {
    guard let reference = vxCreateVirtualImage(graph.reference, vx_uint32(width), vx_uint32(height), type.vx_value) else {
      return nil
    }
    self.reference = reference
  }

  deinit {
    vxReleaseImage(reference)
  }
}
