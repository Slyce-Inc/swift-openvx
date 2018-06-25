import Clibvisionworks


public class VirtualArray: Referenceable {
  public let reference: vx_array

  public init!(graph: Graph, type: DataType, count: Int) {
    guard let reference = vxCreateVirtualArray(graph.reference, type.vx_value, vx_size(count)) else {
      return nil
    }
    self.reference = reference
  }

  deinit {
    var r: vx_reference? = self.reference
    vxReleaseReference(&r)
  }
}
