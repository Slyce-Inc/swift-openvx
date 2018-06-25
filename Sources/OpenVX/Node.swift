import Clibvisionworks

public class Node: Referenceable {
  public let reference: vx_node

  init!(reference: vx_node) {
    vxRetainReference(reference)
    self.reference = reference
  }

  public init?(graph: Graph, kernel: Kernel) {
    guard let reference = vxCreateGenericNode(graph.reference, kernel.reference) else {
      return nil
    }
    self.reference = reference
  }

  public func setParameters(_ parameters: [Referenceable?]) throws {
    for (index, value) in parameters.enumerated() {
      try setParameter(at: index, value: value)
    }
  }

  public func setParameter(at index: Int, value: Referenceable?) throws {
    if case let status = vxSetParameterByIndex(self.reference, vx_uint32(index), value?.reference), VX_SUCCESS != status {
      throw NodeError.FailedToSetParameter(atIndex:index, status: status)
    }
  }

  public func assignCallback(_ block: @escaping @convention(c) (vx_node?) -> Int32) {
    vxAssignNodeCallback(self.reference, block)
  }

  deinit {
    var r: vx_reference? = self.reference
    vxReleaseReference(&r)
  }
}

public extension Node {
  public func setBorder(_ border: Border) {
    var b = border
    vxSetNodeAttribute(self.reference, Int32(VX_NODE_BORDER.rawValue), &b, MemoryLayout.size(ofValue: b))
  }
}

public typealias Border = vx_border_t
public typealias PixelValue = vx_pixel_value_t


public enum NodeError: Error {
case FailedToSetParameter(atIndex: Int, status: vx_status)
}
