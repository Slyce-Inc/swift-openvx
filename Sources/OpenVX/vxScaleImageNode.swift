import Clibvisionworks


public func vxScaleImageNode(_ graph: Graph, _ input: Imageable, _ output: Imageable, _ interpolationPolicy: InterpolationPolicy) -> Node? {
  guard let reference = vxScaleImageNode(graph.reference, input.reference, output.reference, interpolationPolicy.vx_value) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  public func scale(to targetImage:Imageable, interpolationPolicy:InterpolationPolicy) -> Pipeline {
    return self
      .byChanging(node:vxScaleImageNode(graph, lastImageOrFail(), targetImage, interpolationPolicy))
      .byChanging(images:self.images.appending(targetImage))
  }
}
