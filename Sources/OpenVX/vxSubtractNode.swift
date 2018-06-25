import Clibvisionworks


public func vxSubtractNode(_ graph: Graph, _ input1: Imageable, _ input2: Imageable, _ policy: ConversionPolicy, _ output: Imageable) -> Node? {
  guard let reference = vxSubtractNode(graph.reference, input1.reference, input2.reference, policy.vx_value, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  public func subtract(image: Imageable, policy: ConversionPolicy) -> Pipeline {
    let targetImage = virtualImageOrFail(type: .U8)
    return self
      .byChanging(node:vxSubtractNode(graph, lastImageOrFail(), image, policy, targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}
