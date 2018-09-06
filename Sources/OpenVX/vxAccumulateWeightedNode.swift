import Clibvisionworks


public func vxAccumulateWeightedImageNode(_ graph: Graph, _ input: Imageable, _ alpha: Scalar<Float>, _ output: Imageable) -> Node? {
  guard let reference = vxAccumulateWeightedImageNode(graph.reference, input.reference, alpha.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  public func accumulateWeighted(into image: Imageable, alpha: Scalar<Float>) -> Pipeline {
    let targetImage = targetImageOrFail(type: .U8)
    return self
      .byChanging(node:vxAccumulateWeightedImageNode(graph, lastImageOrFail(), alpha, targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}
