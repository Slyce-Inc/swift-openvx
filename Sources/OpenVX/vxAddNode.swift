import Clibvisionworks


public func vxAddNode(_ graph: Graph, _ input1: Imageable, _ input2: Imageable, _ policy: ConversionPolicy, _ output: Imageable) -> Node? {
  guard let reference = vxAddNode(graph.reference, input1.reference, input2.reference, policy.vx_value, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  public func add(image: Imageable, policy: ConversionPolicy) -> Pipeline {
    let targetImage = targetImageOrFail(type: .U8)
    return self
      .byChanging(node:vxAddNode(graph, lastImageOrFail(), image, policy, targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}
