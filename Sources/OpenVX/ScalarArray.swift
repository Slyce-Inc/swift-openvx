import Clibvisionworks


public class ScalarArray: Referenceable {
  public let reference: vx_array

  public init!(graph: Graph, type: DataType, count: Int, virtual:Bool = true) {
    if virtual {
      guard let reference = vxCreateVirtualArray(graph.reference, type.vx_value, vx_size(count)) else {
        return nil
      }
      self.reference = reference
    } else {
      guard let reference = vxCreateArray(graph.reference, type.vx_value, vx_size(count)) else {
        return nil
      }
      self.reference = reference
    }
  }

  deinit {
    var r: vx_reference? = self.reference
    vxReleaseReference(&r)
  }
}
